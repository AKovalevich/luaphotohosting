local lapis = require("lapis")
local app = lapis.Application()

app:get("/api/v1/test", function(self)
    return { json = { status = 'Hello!' } }
end)

return app;
