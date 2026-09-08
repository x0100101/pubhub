# PubHub Deploy Bundle

## Что внутри

```
deploy/
├── api/index.py           ← Flask backend (key system + feedback + Lootlabs)
├── public/
│   ├── loader.lua         ← entry point (загружается юзерами через loadstring)
│   └── main.lua           ← обфусцированный Steal-an-Egg cheat
├── vercel.json            ← роутинг Vercel
└── requirements.txt       ← Python deps
```

## Шаг 1 — Создай Upstash Redis (бесплатно)

1. https://console.upstash.com → Sign up
2. Create Database → Name: `pubhub-keys`, Region: EU/Ireland (ближе к LO)
3. Copy `UPSTASH_REDIS_REST_URL` и `UPSTASH_REDIS_REST_TOKEN`

## Шаг 2 — Deploy на Vercel

```bash
cd deploy
npm i -g vercel
vercel login
vercel
# Project name: pubhub
```

После первого деплоя:
```bash
vercel env add PUBHUB_SECRET       # случайная строка 64 символа
vercel env add PUBHUB_ADMIN        # ваш админ токен
vercel env add UPSTASH_REDIS_REST_URL
vercel env add UPSTASH_REDIS_REST_TOKEN
vercel env add DISCORD_WEBHOOK     # (опционально) для feedback
vercel --prod
```

Запишите URL, например `https://pubhub.vercel.app`.

## Шаг 3 — Обнови loader.lua и main.lua

В `public/loader.lua` замени:
```lua
local PUBHUB_API = "https://pubhub.vercel.app"  -- твой Vercel URL
local MAIN_PAYLOAD_URL = "https://pubhub.vercel.app/main.lua"
```

В `public/main.lua` (обфусцированный) — это уже сделано обфускатором, но FEEDBACK_URL внутри
тоже надо было подменить **до** обфускации. Если деплой URL уже известен — пересобери:
```bash
# в pubhub_main.lua меняем FEEDBACK_URL на реальный
sed -i 's|https://YOUR-DOMAIN.com|https://pubhub.vercel.app|g' pubhub_main.lua
python3 obfuscator.py pubhub_main.lua deploy/public/main.lua --level high
```

## Шаг 4 — Залей на Vercel снова

```bash
vercel --prod
```

## Шаг 5 — Финальный loadstring

```
loadstring(game:HttpGet("https://pubhub.vercel.app/loader.lua"))()
```

Этот однострочник — то, что постим на rscripts/scriptblox/haxhell.

## Lootlabs — настройка линка

Сейчас backend создаёт Lootlabs линк динамически через `/links/create`. Чтобы
это заработало, API ключ должен быть **Creator** ключом с правами создания линков.

Если получаешь 401/403 на `/getlink` — зайди на https://creators.lootlabs.gg,
создай линк вручную с редиректом на `https://pubhub.vercel.app/redeem?t={token}`
(placeholder не сработает — нужен backend), или напиши LO и мы переделаем
на static-link + webhook вариант.

## Admin API

```bash
curl -H "X-Admin: $PUBHUB_ADMIN" https://pubhub.vercel.app/admin/stats
curl -X POST -H "X-Admin: $PUBHUB_ADMIN" -H "Content-Type: application/json" \
     -d '{"hwid":"<hwid-to-ban>"}' https://pubhub.vercel.app/admin/blacklist
curl -X POST -H "X-Admin: $PUBHUB_ADMIN" -H "Content-Type: application/json" \
     -d '{"key":"PUB-XXXX-XXXX-XXXX-XXXX"}' https://pubhub.vercel.app/admin/key/delete
```
