# PubHub Key System Backend — Vercel Serverless + Upstash Redis
# Deploy: vercel deploy
# Env vars: PUBHUB_SECRET, PUBHUB_ADMIN, UPSTASH_REDIS_REST_URL, UPSTASH_REDIS_REST_TOKEN

import os
import json
import time
import hmac
import hashlib
import secrets
import urllib.request
import urllib.error
from datetime import datetime
from flask import Flask, request, jsonify, abort

app = Flask(__name__)

# ─── CONFIG ────────────────────────────────────────────────────────────────
LOOTLABS_API_KEY = os.environ.get("LOOTLABS_API_KEY", "a4775a157efca5c1905cc12fc14a549b744895e440a76d2cc9da94118f609ae0")
SECRET_KEY = os.environ.get("PUBHUB_SECRET") or "dev-secret-CHANGE-ME"
ADMIN_TOKEN = os.environ.get("PUBHUB_ADMIN") or "ADMIN_dev"
UPSTASH_URL = os.environ.get("UPSTASH_REDIS_REST_URL", "").rstrip("/")
UPSTASH_TOKEN = os.environ.get("UPSTASH_REDIS_REST_TOKEN", "")

DURATIONS = {2: 12, 3: 24, 5: 48}
# Реальный Lootlabs API endpoint (из официальной доки):
LOOTLABS_CREATE_URL = "https://creators.lootlabs.gg/api/public/content_locker"
RATE_LIMIT_PER_MIN = 10
KEY_RATE_LIMIT_PER_DAY = 6
TOKEN_TTL = 3600
API_TIMEOUT = 10

# ─── REDIS ─────────────────────────────────────────────────────────────────
def redis_call(*cmd):
    """Upstash REST: POST / with JSON array command"""
    if not UPSTASH_URL or not UPSTASH_TOKEN:
        raise RuntimeError("Upstash not configured")
    req = urllib.request.Request(
        UPSTASH_URL,
        data=json.dumps(list(cmd)).encode(),
        headers={"Authorization": f"Bearer {UPSTASH_TOKEN}", "Content-Type": "application/json"},
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=API_TIMEOUT) as r:
        return json.loads(r.read().decode()).get("result")

def redis_get(k):
    try: return redis_call("GET", k)
    except Exception: return None

def redis_set(k, v, ex=None):
    cmd = ["SET", k, v]
    if ex: cmd += ["EX", str(ex)]
    try: return redis_call(*cmd)
    except Exception: return None

def redis_incr(k):
    try: return redis_call("INCR", k)
    except Exception: return 0

def redis_expire(k, sec):
    try: return redis_call("EXPIRE", k, str(sec))
    except Exception: return None

def redis_sadd(k, m):
    try: return redis_call("SADD", k, m)
    except Exception: return 0

def redis_sismember(k, m):
    try: return redis_call("SISMEMBER", k, m) == 1
    except Exception: return False

# ─── HELPERS ───────────────────────────────────────────────────────────────
def now() -> int: return int(time.time())

def sign_response(hwid: str, expires_at: int) -> str:
    return hmac.new(SECRET_KEY.encode(), f"{hwid}|{expires_at}|valid".encode(), hashlib.sha256).hexdigest()

def sign_key(hwid: str, ckpts: int, issued: int, hours: int) -> str:
    msg = f"{hwid}|{ckpts}|{issued}|{hours}".encode()
    return hmac.new(SECRET_KEY.encode(), msg, hashlib.sha256).hexdigest()[:40].upper()

def format_key(hwid: str, ckpts: int, issued: int, hours: int) -> str:
    sig = sign_key(hwid, ckpts, issued, hours)
    return f"PUB-{sig[:4]}-{sig[4:8]}-{sig[8:12]}-{sig[12:16]}"

def get_ip():
    return (request.headers.get("CF-Connecting-IP")
            or (request.headers.get("X-Forwarded-For") or "").split(",")[0].strip()
            or request.remote_addr or "?")

def blacklisted(hwid: str) -> bool:
    return redis_sismember("bl", hwid)

def rate_check_ok(hwid: str) -> bool:
    w = now() // 60
    k = f"rc:{hwid}:{w}"
    n = redis_incr(k)
    if n == 1: redis_expire(k, 70)
    return n <= RATE_LIMIT_PER_MIN

def rate_key_ok(hwid: str) -> bool:
    day = datetime.utcnow().strftime("%Y-%m-%d")
    k = f"rk:{hwid}:{day}"
    n = redis_incr(k)
    if n == 1: redis_expire(k, 86400)
    return n <= KEY_RATE_LIMIT_PER_DAY

def create_lootlabs_link(checkpoints: int, redeem_url: str):
    """
    Создать Lootlabs content-locker.
    Реальный API: POST https://creators.lootlabs.gg/api/public/content_locker
    Body: {"title","url","tier_id","number_of_tasks","theme"}
    Response: {"type":"created","message":{"loot_url":"https://loot-link.com/s?xxxx",...}}
    """
    payload = {
        "title": f"PubHub {DURATIONS[checkpoints]}h Key",
        "url": redeem_url,
        "tier_id": 1,
        "number_of_tasks": checkpoints,
        "theme": 1,
    }
    headers = {
        "Authorization": f"Bearer {LOOTLABS_API_KEY}",
        "Content-Type": "application/json",
        "User-Agent": "PubHub-KeySystem/1.0",
    }
    req = urllib.request.Request(
        LOOTLABS_CREATE_URL,
        data=json.dumps(payload).encode(),
        headers=headers,
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=API_TIMEOUT) as r:
            body = json.loads(r.read().decode())
            if body.get("type") in ("created", "fetch"):
                msg = body.get("message")
                # message может быть list [{...}] или dict {...}
                if isinstance(msg, list) and msg:
                    msg = msg[0]
                if isinstance(msg, dict):
                    link = msg.get("loot_url") or msg.get("url")
                    if link: return link, None
                return None, f"no loot_url in response: {body}"
            return None, f"lootlabs error: {body}"
    except urllib.error.HTTPError as e:
        body = e.read().decode(errors="ignore")[:500]
        return None, f"lootlabs HTTP {e.code}: {body}"
    except Exception as e:
        return None, f"lootlabs request failed: {e}"

# ─── ROUTES ────────────────────────────────────────────────────────────────
@app.route("/")
def index():
    return jsonify({"service": "PubHub Key System", "ok": True})

@app.route("/payload")
def payload():
    """
    Отдаёт обфусцированный main.lua — только если у юзера есть валидный ключ.
    ?key=PUB-...&hw=<hwid>
    Альтернатива GitHub raw — если main лежит на этом же Vercel.
    """
    key = (request.args.get("key") or "").strip().upper()
    hwid = (request.args.get("hw") or "").strip()[:64]
    if not key or not hwid:
        return "-- unauthorized", 403
    raw = redis_get(f"key:{key}")
    if not raw:
        return "-- unauthorized", 403
    try: kd = json.loads(raw)
    except Exception: return "-- error", 500
    if not hmac.compare_digest(kd["hwid"], hwid) or now() > kd["expires_at"]:
        return "-- unauthorized", 403
    try:
        import os
        path = os.path.join(os.path.dirname(__file__), "..", "public", "main.lua")
        with open(path, "r", encoding="utf-8") as f:
            return f.read(), 200, {"Content-Type": "text/plain; charset=utf-8"}
    except Exception as e:
        return f"-- payload error: {e}", 500

@app.route("/getlink")
def getlink():
    """
    Создаёт Lootlabs линк. Юзер проходит чекпоинты → Lootlabs дёргает наш /postback
    с click_id=TOKEN → мы выдаём ключ.
    """
    hwid = (request.args.get("hw") or "").strip()[:64]
    try: ckpts = int(request.args.get("c", "0"))
    except ValueError: return jsonify({"error": "bad checkpoints"}), 400
    if not hwid or len(hwid) < 6: return jsonify({"error": "bad hwid"}), 400
    if ckpts not in DURATIONS: return jsonify({"error": "checkpoints 2|3|5"}), 400
    if blacklisted(hwid): return jsonify({"error": "hwid blocked"}), 403
    if not rate_key_ok(hwid): return jsonify({"error": "rate limit"}), 429

    token = secrets.token_urlsafe(24)
    # Lootlabs редиректит юзера на эту страницу после всех чекпоинтов (там он увидит ключ)
    redeem_url = request.url_root.rstrip("/") + f"/redeem?t={token}"
    # Сохраняем token как pending — ждём postback от Lootlabs
    redis_set(f"tok:{token}", json.dumps({
        "hwid": hwid, "ckpts": ckpts,
        "completed_tasks": 0, "used": 0,
    }), ex=TOKEN_TTL)

    link, err = create_lootlabs_link(ckpts, redeem_url)
    if err:
        return jsonify({"error": err}), 502
    # Lootlabs шлёт postback с click_id=<token> — подклеиваем его в URL через &puid=
    postback_link = link + ("&" if "?" in link else "?") + f"puid={token}"
    return jsonify({"url": postback_link, "checkpoints": ckpts, "hours": DURATIONS[ckpts], "token": token})


@app.route("/postback")
def postback():
    """
    Lootlabs дёргает сюда после КАЖДОГО пройденного чекпоинта.
    Query: click_id=<puid из loot_url>, ip=<user_ip>, unique_id=<task_id>
    Настраивается в Lootlabs panel → Advanced → Postback URL = https://.../postback
    """
    click_id = (request.args.get("click_id") or "").strip()[:128]
    user_ip = (request.args.get("ip") or "").strip()[:45]
    unique_id = (request.args.get("unique_id") or "").strip()[:64]
    if not click_id or not unique_id:
        return "MISSING", 400

    raw = redis_get(f"tok:{click_id}")
    if not raw: return "UNKNOWN_TOKEN", 404
    try: tdata = json.loads(raw)
    except Exception: return "CORRUPT", 500
    if tdata.get("used"): return "USED", 200  # уже выдали ключ, но 200 чтобы Lootlabs не ретраил

    # Защита от дублей одного task
    if redis_sismember(f"pb:{click_id}", unique_id):
        return "DUPLICATE", 200
    redis_sadd(f"pb:{click_id}", unique_id)
    redis_expire(f"pb:{click_id}", TOKEN_TTL)

    tdata["completed_tasks"] = tdata.get("completed_tasks", 0) + 1
    tdata["user_ip"] = user_ip

    # Если все чекпоинты пройдены — выдаём ключ
    if tdata["completed_tasks"] >= tdata["ckpts"]:
        tdata["used"] = 1
        hwid, ckpts = tdata["hwid"], tdata["ckpts"]
        hours = DURATIONS[ckpts]
        issued = now()
        expires = issued + hours * 3600
        key = format_key(hwid, ckpts, issued, hours)
        tdata["key"] = key
        tdata["expires_at"] = expires
        # Сохраняем ключ в redis
        redis_set(f"key:{key}", json.dumps({
            "hwid": hwid, "ckpts": ckpts, "hours": hours,
            "created_at": issued, "expires_at": expires,
            "ip": user_ip, "ua": "lootlabs-postback",
        }), ex=hours * 3600 + 3600)
        redis_incr("stats:total")
        redis_incr(f"stats:day:{datetime.utcnow().strftime('%Y-%m-%d')}")
        redis_set(f"tok:{click_id}", json.dumps(tdata), ex=3600)  # редирект заберёт ключ в течение часа
        return "OK_KEY_ISSUED", 200

    redis_set(f"tok:{click_id}", json.dumps(tdata), ex=TOKEN_TTL)
    return f"OK_PROGRESS_{tdata['completed_tasks']}/{tdata['ckpts']}", 200

@app.route("/redeem")
def redeem():
    """
    Юзер попадает сюда после прохождения всех чекпоинтов (Lootlabs редирект).
    Ключ уже создан postback'ом — просто показываем его.
    """
    token = (request.args.get("t") or "").strip()[:128]
    if not token: return "<h1>Bad request</h1>", 400
    raw = redis_get(f"tok:{token}")
    if not raw: return "<h1>Сессия не найдена</h1><p>Запросите новую ссылку.</p>", 404
    try: tdata = json.loads(raw)
    except Exception: return "<h1>Bad session</h1>", 500

    # Проверяем что postback уже выдал ключ
    if not tdata.get("used") or not tdata.get("key"):
        completed = tdata.get("completed_tasks", 0)
        ckpts = tdata.get("ckpts", "?")
        return f"""<!doctype html><html><head><meta charset=utf-8><meta http-equiv=refresh content=5><title>PubHub — Waiting</title>
<style>body{{background:#0a0c14;color:#e8ecf8;font-family:sans-serif;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0}}
.card{{background:#12141f;padding:2rem;border-radius:16px;border:1px solid #8b5cf6;text-align:center}}</style></head>
<body><div class=card><h1 style="color:#8b5cf6">PubHub</h1><p>Прогресс: {completed}/{ckpts} чекпоинтов</p><p>Страница обновится автоматически...</p></div></body></html>""", 202

    key = tdata["key"]
    expires = tdata["expires_at"]
    hours = DURATIONS.get(tdata["ckpts"], 0)

    html = f"""<!doctype html><html><head><meta charset=utf-8><title>PubHub — Key</title>
<meta name=viewport content="width=device-width,initial-scale=1">
<style>
body{{background:#0a0c14;color:#e8ecf8;font-family:Inter,system-ui,sans-serif;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0;padding:1rem}}
.card{{background:linear-gradient(135deg,#12141f 0%,#1a1030 100%);padding:2.5rem 3rem;border-radius:20px;border:1px solid #8b5cf6;max-width:520px;text-align:center;box-shadow:0 20px 60px -20px rgba(139,92,246,.4)}}
h1{{background:linear-gradient(90deg,#8b5cf6,#ec4899);-webkit-background-clip:text;background-clip:text;color:transparent;margin:0 0 .5rem;font-size:2.2rem}}
.key{{font-family:'JetBrains Mono',monospace;font-size:1.25rem;background:#0f1119;padding:1.2rem;border-radius:12px;margin:1.5rem 0;user-select:all;border:1px solid #8b5cf6;letter-spacing:1px;color:#c4b5fd}}
p{{color:#9aa3c0;line-height:1.5}}
.badge{{display:inline-block;background:#8b5cf6;color:#fff;padding:.3rem .8rem;border-radius:99px;font-size:.85rem;font-weight:600}}
</style></head><body><div class=card>
<h1>PubHub</h1>
<span class=badge>{hours} часов</span>
<p>Ваш ключ готов — скопируйте и вставьте в окно PubHub в Roblox</p>
<div class=key>{key}</div>
<p style=font-size:.85rem>Истекает: {datetime.utcfromtimestamp(expires).strftime('%Y-%m-%d %H:%M UTC')}</p>
</div></body></html>"""
    return html

@app.route("/check")
def check():
    key = (request.args.get("key") or "").strip().upper()
    hwid = (request.args.get("hw") or "").strip()[:64]
    if not key or not hwid:
        return jsonify({"valid": False, "error": "missing params"}), 400
    if blacklisted(hwid):
        return jsonify({"valid": False, "error": "hwid blocked"}), 403
    if not rate_check_ok(hwid):
        return jsonify({"valid": False, "error": "rate limit"}), 429

    raw = redis_get(f"key:{key}")
    if not raw:
        return jsonify({"valid": False, "error": "key not found"})
    try: kd = json.loads(raw)
    except Exception: return jsonify({"valid": False, "error": "corrupt"}), 500
    if not hmac.compare_digest(kd["hwid"], hwid):
        return jsonify({"valid": False, "error": "key bound to another hwid"})
    t = now()
    if t > kd["expires_at"]:
        return jsonify({"valid": False, "error": "expired", "expired_at": kd["expires_at"]})

    return jsonify({
        "valid": True,
        "remaining": kd["expires_at"] - t,
        "expires_at": kd["expires_at"],
        "hours": kd["hours"],
        "sig": sign_response(hwid, kd["expires_at"]),
    })

# ─── FEEDBACK (used by PubHub main script) ─────────────────────────────────
@app.route("/feedback", methods=["POST"])
def feedback():
    """Проксирует фидбек в Discord webhook (если задан) или сохраняет в Redis."""
    try:
        j = request.get_json(force=True) or {}
    except Exception:
        return jsonify({"success": False, "error": "bad_request"}), 400
    msg = (j.get("message") or "").strip()
    ftype = (j.get("type") or "Suggestion").strip()
    if not msg: return jsonify({"success": False, "error": "empty"}), 200
    if "http" in msg.lower() or "@" in msg: return jsonify({"success": False, "error": "no_links"}), 200
    if len(msg) > 500: return jsonify({"success": False, "error": "too_long"}), 200

    hwid = (j.get("hwid") or "")[:64]
    rate_k = f"fb:{hwid}:{now() // 3600}"
    n = redis_incr(rate_k)
    if n == 1: redis_expire(rate_k, 3700)
    if n > 3: return jsonify({"success": False, "error": "rate_limited"}), 200

    webhook = os.environ.get("DISCORD_WEBHOOK", "")
    if webhook:
        try:
            payload = {
                "username": "PubHub Feedback",
                "embeds": [{
                    "title": f"[{ftype}] from {j.get('username','?')}",
                    "description": msg,
                    "color": 0x8b5cf6,
                    "fields": [
                        {"name": "PlaceId", "value": str(j.get("placeId","?")), "inline": True},
                        {"name": "Version", "value": str(j.get("version","?")), "inline": True},
                        {"name": "HWID", "value": hwid[:16]+"...", "inline": True},
                    ],
                    "timestamp": datetime.utcnow().isoformat() + "Z",
                }],
            }
            req = urllib.request.Request(webhook,
                data=json.dumps(payload).encode(),
                headers={"Content-Type": "application/json"},
                method="POST")
            urllib.request.urlopen(req, timeout=5)
        except Exception:
            pass  # silent fail — не блокируем юзера
    else:
        # сохраняем в Redis для ручного просмотра
        redis_call("LPUSH", "fb:list", json.dumps({"t": now(), "type": ftype, "msg": msg, "hwid": hwid[:16]}))

    return jsonify({"success": True})

# ─── ADMIN ─────────────────────────────────────────────────────────────────
def require_admin():
    if request.headers.get("X-Admin") != ADMIN_TOKEN: abort(403)

@app.route("/admin/stats")
def admin_stats():
    require_admin()
    day = datetime.utcnow().strftime("%Y-%m-%d")
    return jsonify({
        "total": int(redis_get("stats:total") or 0),
        "today": int(redis_get(f"stats:day:{day}") or 0),
    })

@app.route("/admin/blacklist", methods=["POST"])
def admin_blacklist():
    require_admin()
    j = request.get_json(force=True) or {}
    hwid = (j.get("hwid") or "").strip()
    if not hwid: return jsonify({"error": "no hwid"}), 400
    redis_sadd("bl", hwid)
    return jsonify({"ok": True})

@app.route("/admin/key/delete", methods=["POST"])
def admin_delete():
    require_admin()
    j = request.get_json(force=True) or {}
    key = (j.get("key") or "").strip().upper()
    redis_call("DEL", f"key:{key}")
    return jsonify({"ok": True})

# Vercel handler
def handler(request_obj, context=None):
    return app(request_obj.environ, lambda *a, **kw: None)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
