# discord_roles

Automatically add players to principals based on their roles in a Discord guild.

# Dependencies

- [discord_rest](https://github.com/kibook/discord_rest)

# Installation

1. Install all [dependencies](#dependencies).

2. Clone to a folder in your resources directory:

   ```sh
   cd resources/[local]
   git clone https://github.com/kibook/discord_roles
   ```

3. Set your Discord guild ID in [config.lua](config.lua).

4. Optionally set a bot token in [config.lua](config.lua), or leave it commented out to use the default token set for [discord_rest](https://github.com/kibook/discord_rest).

5. Add the following to server.cfg:

   ```
   exec @discord_roles/permissions.cfg
   start discord_roles
   ```

6. Restart your server.

# Usage

Players will automatically be added to and removed from principals based on their Discord roles as they join the server. The principals are named in the form of:

```
discord.role:<role ID>
```

These principals can then be used to add players to other principals or to add aces:

```
# Add players with the Moderator role on Discord to group.moderator
add_principal discord.role:<ID of Moderator role> group.moderator
```

```
# Add a tag in chat for players with the Friend role on Discord (see https://github.com/kibook/poodlechat)
add_ace discord.role:<ID of Friend role> chat.friend allow
```

To force a refresh of roles (for example, after modifying roles on Discord), use the `refresh_discord_roles` command.
