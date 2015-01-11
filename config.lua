-- config.lua
local config = require("lapis.config")
-- Database settings
config("development", {
    postgres = {
        backend = "pgmoon",
        host = "127.0.0.1",
        user = "boo",
        password = "87654321",
        database = "test",
    }
})

--config("production", {
--    postgres = {
--        backend = "pgmoon",
--        host = "",
--        user = "",
--        password = "",
--        database = "",
--    }
--})