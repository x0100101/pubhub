import asyncio
import os
import sqlite3
from html import escape
from aiogram import Bot, Dispatcher, F
from aiogram.types import (
    Message, CallbackQuery,
    InlineKeyboardMarkup, InlineKeyboardButton,
    FSInputFile,
)
from aiogram.filters import Command, CommandStart
from aiogram.fsm.context import FSMContext
from aiogram.fsm.state import State, StatesGroup
from aiogram.fsm.storage.memory import MemoryStorage


def _to_html(text: str, entities) -> str:
    """Рендер MessageEntity[] → HTML для parse_mode=HTML."""
    if not text:
        return ""
    if not entities:
        return escape(text)
    # сортируем по offset, чтобы корректно вложить
    ents = sorted(entities, key=lambda e: (e.offset, -e.length))
    out = []
    cur = 0
    stack = []  # (end_offset, closing_tag)
    def open_tag(e):
        t = e.type
        if t == "bold": return "<b>"
        if t == "italic": return "<i>"
        if t == "underline": return "<u>"
        if t == "strikethrough": return "<s>"
        if t == "code": return "<code>"
        if t == "pre": return "<pre>"
        if t == "text_link": return f'<a href="{escape(e.url or "", quote=True)}">'
        if t == "spoiler": return "<tg-spoiler>"
        if t == "blockquote": return "<blockquote>"
        return None
    close_map = {"<b>": "</b>", "<i>": "</i>", "<u>": "</u>", "<s>": "</s>",
                 "<code>": "</code>", "<pre>": "</pre>", "<a": "</a>",
                 "<tg-spoiler>": "</tg-spoiler>", "<blockquote>": "</blockquote>"}
    def close_for(tag):
        for k, v in close_map.items():
            if tag.startswith(k):
                return v
        return ""
    i = 0
    pos = 0
    active = []  # list of (end, tag, closetag)
    while pos < len(text):
        # закрываем истёкшие теги
        while active and active[0][0] <= pos:
            _, _, ct = active.pop(0)
            out.append(ct)
        # открываем новые, начинающиеся на pos
        while i < len(ents) and ents[i].offset == pos:
            e = ents[i]
            ot = open_tag(e)
            if ot:
                active.append((e.offset + e.length, ot, close_for(ot)))
                active.sort(key=lambda x: x[0])
                out.append(ot)
            i += 1
        out.append(escape(text[pos]))
        pos += 1
    while active:
        _, _, ct = active.pop(0)
        out.append(ct)
    return "".join(out)


def msg_html(m: Message) -> str:
    return _to_html(m.text or "", m.entities or [])


def caption_html_of(m: Message) -> str:
    return _to_html(m.caption or "", m.caption_entities or [])

BOT_TOKEN = "8876965395:AAFvSoo4JS96K186X0OUjT7pa6GNwVLHFXc"
ADMIN_IDS = {645660315, 7839444854}
DB = "bot.db"

bot = Bot(BOT_TOKEN)
dp = Dispatcher(storage=MemoryStorage())

# ---------- DB ----------
def db_init():
    c = sqlite3.connect(DB)
    c.execute("""CREATE TABLE IF NOT EXISTS settings(
        key TEXT PRIMARY KEY, value TEXT)""")
    c.execute("""CREATE TABLE IF NOT EXISTS media(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_id TEXT, mtype TEXT, caption TEXT)""")
    defaults = {
        "channel": "",            # @username или -100id
        "channel_link": "",       # invite-ссылка для приватного канала
        "gate_text": "Чтобы получить информацию, вы должны быть подписаны на канал",
        "not_subbed_text": "Вы ещё не подписаны",
        "success_text": "Спасибо за подписку! Вот ваша информация:",
        "payload_text": "",       # основной текст, выдаваемый после подписки
        "welcome_text": "Нажми кнопку ниже, чтобы получить информацию.",
    }
    for k, v in defaults.items():
        c.execute("INSERT OR IGNORE INTO settings(key,value) VALUES(?,?)", (k, v))
    c.commit(); c.close()

def get_setting(key):
    c = sqlite3.connect(DB)
    r = c.execute("SELECT value FROM settings WHERE key=?", (key,)).fetchone()
    c.close()
    return r[0] if r else ""

def set_setting(key, value):
    c = sqlite3.connect(DB)
    c.execute("INSERT INTO settings(key,value) VALUES(?,?) "
              "ON CONFLICT(key) DO UPDATE SET value=excluded.value", (key, value))
    c.commit(); c.close()

def media_all():
    c = sqlite3.connect(DB)
    rows = c.execute("SELECT id, file_id, mtype, caption FROM media ORDER BY id").fetchall()
    c.close(); return rows

def media_add(file_id, mtype, caption):
    c = sqlite3.connect(DB)
    c.execute("INSERT INTO media(file_id,mtype,caption) VALUES(?,?,?)",
              (file_id, mtype, caption))
    c.commit(); c.close()

def media_del(mid):
    c = sqlite3.connect(DB)
    c.execute("DELETE FROM media WHERE id=?", (mid,))
    c.commit(); c.close()

# ---------- Keyboards ----------
def kb_get_info():
    return InlineKeyboardMarkup(inline_keyboard=[[
        InlineKeyboardButton(text="📩 Получить информацию", callback_data="get_info")
    ]])

def kb_subscribe():
    ch = get_setting("channel")
    link = get_setting("channel_link")
    if not link:
        link = f"https://t.me/{ch.lstrip('@')}" if ch.startswith("@") else ""
    row_sub = [InlineKeyboardButton(text="📢 Подписаться", url=link)] if link else []
    return InlineKeyboardMarkup(inline_keyboard=[
        row_sub,
        [InlineKeyboardButton(text="✅ Проверить", callback_data="check_sub")],
    ])

def kb_admin():
    return InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="✏️ Текст приветствия", callback_data="adm_welcome_text")],
        [InlineKeyboardButton(text="✏️ Текст гейта", callback_data="adm_gate_text")],
        [InlineKeyboardButton(text="✏️ Текст «не подписан»", callback_data="adm_not_subbed_text")],
        [InlineKeyboardButton(text="✏️ Текст успеха", callback_data="adm_success_text")],
        [InlineKeyboardButton(text="✏️ Основной текст (выдача)", callback_data="adm_payload_text")],
        [InlineKeyboardButton(text="📢 Задать канал", callback_data="adm_channel")],
        [InlineKeyboardButton(text="🔗 Ссылка-приглашение", callback_data="adm_channel_link")],
        [InlineKeyboardButton(text="📎 Добавить медиа", callback_data="adm_add_media")],
        [InlineKeyboardButton(text="🗑 Список/удаление медиа", callback_data="adm_list_media")],
    ])

# ---------- Sub check ----------
async def is_subscribed(user_id: int) -> bool:
    ch = get_setting("channel")
    if not ch:
        return False
    try:
        m = await bot.get_chat_member(ch, user_id)
        return m.status in ("member", "administrator", "creator")
    except Exception:
        return False

async def send_payload(target, user_id: int):
    """Выдача: одно сообщение = фото + caption (success+payload+caption, со ссылкой)."""
    success = get_setting("success_text")
    payload = get_setting("payload_text")

    rows = media_all()
    # собираем общий текст выдачи
    parts = [p for p in (success, payload) if p]
    base_text = "\n\n".join(parts)

    async def _send_media(fid, mtype, cap):
        kw = {"caption": cap, "parse_mode": "HTML"} if cap else {}
        if mtype == "photo":
            await bot.send_photo(user_id, fid, **kw)
        elif mtype == "video":
            await bot.send_video(user_id, fid, **kw)
        elif mtype == "document":
            await bot.send_document(user_id, fid, **kw)
        elif mtype == "audio":
            await bot.send_audio(user_id, fid, **kw)
        elif mtype == "voice":
            await bot.send_voice(user_id, fid)
        elif mtype == "animation":
            await bot.send_animation(user_id, fid, **kw)
        elif mtype == "sticker":
            await bot.send_sticker(user_id, fid)

    if rows:
        # первое медиа = главное: caption = base_text + его собственный caption
        first_id, first_fid, first_type, first_cap = rows[0]
        merged = base_text
        if first_cap:
            merged = f"{base_text}\n\n{first_cap}" if base_text else first_cap
        # лимит caption — 1024
        if len(merged) > 1024:
            merged = merged[:1021] + "…"
        try:
            await _send_media(first_fid, first_type, merged)
        except Exception as e:
            print(f"[media #{first_id}] fail: {e} → fallback")
            try:
                await _send_media(first_fid, first_type, "")
            except Exception as e2:
                print(f"[media #{first_id}] no-caption fail: {e2}")
            if merged:
                await bot.send_message(user_id, merged, parse_mode="HTML",
                                       disable_web_page_preview=False)
        # остальные медиа — со своими caption
        for mid, fid, mtype, cap in rows[1:]:
            try:
                await _send_media(fid, mtype, cap)
            except Exception as e:
                print(f"[media #{mid}] fail: {e}")
                try:
                    await _send_media(fid, mtype, "")
                except Exception as e2:
                    print(f"[media #{mid}] no-caption fail: {e2}")
                if cap:
                    await bot.send_message(user_id, cap, parse_mode="HTML")
    else:
        # медиа нет — просто текст
        if base_text:
            await bot.send_message(user_id, base_text, parse_mode="HTML",
                                   disable_web_page_preview=False)

# ---------- User flow ----------
@dp.message(CommandStart())
async def cmd_start(m: Message):
    await m.answer(get_setting("welcome_text"), reply_markup=kb_get_info())

@dp.callback_query(F.data == "get_info")
async def cb_get_info(cq: CallbackQuery):
    if await is_subscribed(cq.from_user.id):
        await send_payload(cq, cq.from_user.id)
    else:
        await cq.message.answer(get_setting("gate_text"), reply_markup=kb_subscribe())
    await cq.answer()

@dp.callback_query(F.data == "check_sub")
async def cb_check(cq: CallbackQuery):
    if await is_subscribed(cq.from_user.id):
        await send_payload(cq, cq.from_user.id)
    else:
        await cq.message.answer(get_setting("not_subbed_text"), reply_markup=kb_subscribe())
    await cq.answer()

# ---------- Admin FSM ----------
class Adm(StatesGroup):
    waiting_value = State()
    waiting_media = State()

EDIT_KEYS = {"welcome_text", "gate_text", "not_subbed_text",
             "success_text", "payload_text", "channel", "channel_link"}

@dp.message(Command("admin"))
async def cmd_admin(m: Message):
    if m.from_user.id not in ADMIN_IDS:
        return
    cur_ch = get_setting("channel") or "— не задан —"
    await m.answer(f"⚙️ Админ-панель\nКанал: {cur_ch}\n\nВыбери, что меняем:",
                   reply_markup=kb_admin())

@dp.callback_query(F.data.startswith("adm_"))
async def cb_admin(cq: CallbackQuery, state: FSMContext):
    if cq.from_user.id not in ADMIN_IDS:
        await cq.answer("Нет доступа", show_alert=True)
        return
    key = cq.data[4:]

    if key in EDIT_KEYS:
        await state.set_state(Adm.waiting_value)
        await state.update_data(edit_key=key)
        names = {
            "welcome_text": "текст приветствия (/start)",
            "gate_text": "текст гейта",
            "not_subbed_text": "текст «не подписан»",
            "success_text": "текст успеха",
            "payload_text": "основной текст выдачи",
            "channel": "канал (@username или -100ID)",
            "channel_link": "invite-ссылку (https://t.me/+XXXX или https://t.me/joinchat/XXXX)",
        }
        await cq.message.answer(f"Пришли новое значение для: {names[key]}")
    elif key == "add_media":
        await state.set_state(Adm.waiting_media)
        await cq.message.answer(
            "Пришли медиа (фото/видео/файл/аудио/голос/гиф/стикер). "
            "Подпись к сообщению станет caption. /done — закончить.")
    elif key == "list_media":
        rows = media_all()
        if not rows:
            await cq.message.answer("Медиа нет.")
        else:
            kb = [[InlineKeyboardButton(
                text=f"🗑 #{mid} {mtype}",
                callback_data=f"delmedia_{mid}")] for mid, _, mtype, _ in rows]
            await cq.message.answer("Медиа в выдаче:",
                                    reply_markup=InlineKeyboardMarkup(inline_keyboard=kb))
    await cq.answer()

@dp.callback_query(F.data.startswith("delmedia_"))
async def cb_del_media(cq: CallbackQuery):
    if cq.from_user.id not in ADMIN_IDS:
        return
    mid = int(cq.data.split("_")[1])
    media_del(mid)
    await cq.message.edit_text(f"Медиа #{mid} удалено.")
    await cq.answer()

@dp.message(Adm.waiting_value, F.from_user.id.in_(ADMIN_IDS))
async def adm_save_value(m: Message, state: FSMContext):
    data = await state.get_data()
    key = data["edit_key"]
    val = msg_html(m) or (m.text or "")
    if key == "channel":
        val = val.strip()
        if val.startswith("https://t.me/"):
            val = "@" + val.split("/")[-1]
        elif not val.startswith("@") and not val.startswith("-100"):
            val = "@" + val
    set_setting(key, val)
    await state.clear()
    await m.answer(f"Сохранено: {key} ✔", reply_markup=kb_admin())

@dp.message(Adm.waiting_media, F.from_user.id.in_(ADMIN_IDS))
async def adm_save_media(m: Message, state: FSMContext):
    if m.text and m.text.strip() == "/done":
        await state.clear()
        await m.answer("Готово ✔", reply_markup=kb_admin())
        return
    await _ingest_media(m, keep_state=True)

# ловим медиа от админа в ЛЮБОЙ момент — даже без «добавить медиа»
@dp.message(F.from_user.id.in_(ADMIN_IDS),
            F.photo | F.video | F.document | F.audio | F.voice | F.animation | F.sticker)
async def adm_auto_media(m: Message, state: FSMContext):
    cur = await state.get_state()
    if cur == Adm.waiting_media.state:
        return  # уже обработан хендлером выше
    await _ingest_media(m, keep_state=False)

async def _ingest_media(m: Message, keep_state: bool):
    cap = caption_html_of(m) or (m.caption or "")
    if m.photo:
        media_add(m.photo[-1].file_id, "photo", cap)
    elif m.video:
        media_add(m.video.file_id, "video", cap)
    elif m.document:
        media_add(m.document.file_id, "document", cap)
    elif m.audio:
        media_add(m.audio.file_id, "audio", cap)
    elif m.voice:
        media_add(m.voice.file_id, "voice", "")
    elif m.animation:
        media_add(m.animation.file_id, "animation", cap)
    elif m.sticker:
        media_add(m.sticker.file_id, "sticker", "")
    else:
        await m.answer("Это не медиа. Пришли фото/видео/файл.")
        return
    if keep_state:
        await m.answer("Добавлено ✔ Ещё или /done.")
    else:
        await m.answer("Медиа добавлено в выдачу ✔", reply_markup=kb_admin())

# ---------- run ----------
async def _health_server():
    """Tiny HTTP server to satisfy Render Web Service $PORT check."""
    from aiohttp import web
    async def ok(_):
        return web.Response(text="ok")
    app = web.Application()
    app.router.add_get("/", ok)
    app.router.add_get("/health", ok)
    runner = web.AppRunner(app)
    await runner.setup()
    port = int(os.environ.get("PORT", "10000"))
    await web.TCPSite(runner, "0.0.0.0", port).start()
    print(f"health server on :{port}")

async def main():
    db_init()
    await _health_server()
    print("bot started")
    await dp.start_polling(bot)

if __name__ == "__main__":
    asyncio.run(main())
