local lapis = require("lapis")
local app = lapis.Application()

app:get("/test", function(self)
    return { json = { status = 'Hello!' } }
end)

return app;
