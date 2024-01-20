local S = minetest.get_translator("player_spam")
 
local player_spam = {}
local CHAR_REPEAT_MAX = 3 -- максимально допустимое число повторяющихся символов
 
minetest.register_on_chat_message(function(name, msg)
    if msg == "" or msg:sub(1, 1) == '/' then
        return
    end
    if not minetest.check_player_privs(name, {shout = true}) then
        minetest.chat_send_player(name, S("You can not chat. Missing privilege: shout"))
        return true
    end
 
    -- накапливаем счетчик, минимальное значение увеличения любого сообщения - 1, для длинных сообщений будет выше
    local count_as_messages = math.max(1, math.min(msg:len() / 100, 3))
    player_spam[name] = (player_spam[name] or 0) + math.floor(count_as_messages + 0.5) 
 
    -- кик, если выше трёх за интервал
    if player_spam[name] > 3 then
        minetest.kick_player(name, S("You spammer you!"))
        return true
    end
    -- предупреждение в чат игроку, если выше двух за интервал
    if player_spam[name] > 2 then
        minetest.chat_send_player(name, S("Your message was not sent due to flood detection. ")..
                S("Please try again in some seconds."))
        return true
    end
 
    local new_msg = ""
    local last_char
    local same_char_count = 0
 
    -- Усечение повторяющихся символов в сообщении до ограничения CHAR_REPEAT_MAX
    for c in msg:gmatch(".") do
        if c:byte() < 0x20 then
            c = ' '
        end
        if last_char == c:lower() then
            same_char_count = same_char_count + 1
        else
            last_char = c:lower()
            same_char_count = 0
        end
 
        if same_char_count < CHAR_REPEAT_MAX then
            new_msg = new_msg .. c
        end
    end
    if new_msg == msg then
        return
    end
  
    minetest.chat_send_all("<"..name.."> " .. new_msg)

    return true
end)
 
local timed = 0
-- сброс счетчиков сообщений пользователей за интервал CHECK_COUNT
local CHECK_COUNT = 8
minetest.register_globalstep(function(dtime)
    timed = timed + dtime
    if timed < CHECK_COUNT then
        return
    end
    timed = 0
 
    for i, player in pairs(minetest.get_connected_players()) do
        local player_name = player:get_player_name()
        local num = player_spam[player_name]
        if num and num > 0 then
            player_spam[player_name] = math.max(0, num - CHECK_COUNT)
        end
    end
end)
 
-- очистка поля спама при выходе игрока
minetest.register_on_leaveplayer(function(player)
    player_spam[player:get_player_name()] = nil
end)