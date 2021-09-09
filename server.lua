local assignedRoles = {}

local function addRole(discordId, role)
        assignedRoles[discordId][role] = true
        ExecuteCommand(("add_principal identifier.discord:%s discord.role:%s"):format(discordId, role))
end

local function removeRole(discordId, role)
        assignedRoles[discordId][role] = nil
        ExecuteCommand(("remove_principal identifier.discord:%s discord.role:%s"):format(discordId, role))
end

local function removeRoles(discordId)
        if assignedRoles[discordId] then
                for role, _ in pairs(assignedRoles[discordId]) do
                        removeRole(discordId, role)
                end
        end

        assignedRoles[discordId] = {}
end

local function removeRolesForAllPlayers()
        for discordId, roles in pairs(assignedRoles) do
                for role, _ in pairs(roles) do
                        removeRole(discordId, role)
                end
        end
end

local function assignRoles(source)
        exports.discord_rest:getGuildMemberForPlayer(Config.guild, source, Config.botToken):next(function(member)
                removeRoles(member.user.id)

                for _, role in ipairs(member.roles) do
                        addRole(member.user.id, role)
                end
        end)
end

local function assignRolesForAllPlayers()
        for _, player in ipairs(GetPlayers()) do
                assignRoles(player)
        end
end

exports("refreshRoles", assignRoles)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
        assignRoles(source)
end)

AddEventHandler("onResourceStart", function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
                return
        end

        assert(Config.guild and Config.guild ~= "", "No guild specified in config.lua")

        assignRolesForAllPlayers()
end)

AddEventHandler("onResourceStop", function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
                return
        end

        removeRolesForAllPlayers()
end)

RegisterCommand("refresh_discord_roles", function(source, args, raw)
        removeRolesForAllPlayers()
        assignRolesForAllPlayers()
end, true)
