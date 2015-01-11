local bcrypt = require("bcrypt")

local hash = {}
local password = {}

hash.get = function(string)
    local salt = hash.get_hash()
    return assert(bcrypt.digest(string, salt))
end

hash.verify = function(string, hash)
    return bcrypt.verify(string, hash)
end

--TODO hash from config
hash.get_hash = function()
    return bcrypt.salt(4);
end


local translate = {}

--TODO TRANSLATE??
translate.t = function(str)
    return str
end

translate.get_current_lang = function()
    return "ru"
end

return {
    hash = hash,
    translate = translate
}