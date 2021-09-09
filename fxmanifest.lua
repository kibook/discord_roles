fx_version "cerulean"
game "common"

name "discord_roles"
author "kibukj"
description "Automatically add players to principals based on their roles in a Discord guild"
repository "https://github.com/kibook/discord_roles"

dependency "discord_rest" -- https://github.com/kibook/discord_rest

server_scripts {
        "config.lua",
        "server.lua"
}
