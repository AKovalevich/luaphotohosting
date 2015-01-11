-- Autoload
package.path = table.concat({
    package.path,
    "/etc/nginx/app/?.lua",
}, ";")

local lapis = require("lapis")
local Users = (require "model.user").Users
local app = lapis.Application()
local bcrypt = require("bcrypt")
local helper = require("parts.helper")

app:post("/api/v1/register", function(self)
    local request_password = self.params.password:gsub("%s+", "")
    local requset_login = self.params.login:gsub("%s+", "")
    local request_password_confirm = self.params.passwordConfirm:gsub("%s+", "")
    local request_email = self.params.passwordConfirm:gsub("%s+", "")
    local message = ""
    local status = ""
    local data = {}

    local User = Users:find({login = requset_login})

    if User == nil or User == "" then
        local password_length = request_password:len()

        if request_password == request_password_confirm then
            if password_length < 5 then
                status = "error"
                message = helper.translate.t("Пароль должен быть больше 5 символов")
            else
                local hash = helper.hash.get(request_password)
                local user = Users:create_user({
                    login = requset_login,
                    password = hash,
                    email = request_email,
                    created = os.time()
                })
                status = "ok"
                message = "User created"
                data = user
            end

        else
            status = "error"
            message = helper.translate.t("Параль не совпадает")
        end
    else
        status = "error"
        message = helper.translate.t("Пользователь с таким ником уже существует")
    end


    return { json = { status = status, message = message, data = data } }
end)

app:post("/api/v1/login", function(self)
    local request_password = self.params.password:gsub("%s+", "")
    local request_login = self.params.login:gsub("%s+", "")
    local User = Users:find({login = request_login})
    local message = ""
    local status = ""
    local data = {}

    if User == nil or User == "" then
        status = "error"
        message = helper.translate.t("Проверьте логин и пароль")
    else
        local access = bcrypt.verify(request_password, User.password:gsub("%s+", ""))
        if access then
            self.session.uid = User.uid
            message = "User " .. User.uid .. " authorized"
            status = "ok"
            data = {
                uid = User.uid,
                login = User.login,
                created = User.created,
                email = User.email
            }
        else
            status = "error"
            message = helper.translate.t("Проверьте пароль")
        end
    end

    return { json = { status = status, message = message, data = data } }
end)

app:get("/api/v1/test", function(self)
    local data = Users:find(1)
    local test = Users.delete_user(4)
    return { json = { status =  test } }
end)

return app;
