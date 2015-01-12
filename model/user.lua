--local bcrypt = require "bcrypt"
local Model = require("lapis.db.model").Model
local helper = require("parts.helper")
local Users = Model:extend("users", {
    primary_key = "uid"
})

Users.create_user = function(password, login, email, name, last_name)
    local password = password:gsub("%s+", "")
    local email = email:gsub("%s+", "")
--    local name = name:gsub("%s+", "")
--    local last_name = last_name:gsub("%s+", "")
    local login = login:gsub("%s+", "")
    local hash = helper.hash.get(password)

    local data = Users:create({
        login = login,
        password = hash,
        email = email,
        created = os.time(),
--        name = name,
--        last_name = last_name,
--        email = email
    })

    return data
end

Users.delete_user = function(uid)
    local deleting_user = Users:find({uid = uid})
    local data = deleting_user:delete()

    return data;
end

Users.get_user_by_id = function(uid)
    if uid == nil then
        return false
    end
    return Users:find({uid = uid})
end

Users.get_user_by_name = function(name)
    if name == nil then
        return false
    end
    return Users:find({name = name})
end

Users.update = function(data)
    if data == nil then
        return false
    end
    return Users:find(data)
end

return {
    Users = Users
}
