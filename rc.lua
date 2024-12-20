-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            -- Make sure we don't go into an endless error loop
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end
-- }}}

-- {{{ My Variables
gruvbox_dark = "#282828"
gruvbox_light = "#FB4934"
gruvbox_medium = "#504945"
gruvbox_text = "#EBDBB2"

-- THIS NEEDS TO BE SET IN /etc/profile
-- export ENVIRONMENT="home"
environment = os.getenv("ENVIRONMENT")
assert(environment ~= nil, "Environment variable ENVIRONMENT not set")
--- }}}

-- Load custom widgets from ~/.config/awesome/
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/spotify-widget
local spotify_widget
if (environment == "home") then
    spotify_widget = require("spotify-widget.spotify")
end


-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.font = "Terminus 14"
beautiful.taglist_bg_focus = gruvbox_dark
beautiful.taglist_fg_focus = gruvbox_light
beautiful.tasklist_bg_normal = gruvbox_dark
beautiful.tasklist_bg_minimize = gruvbox_dark
beautiful.tasklist_bg_focus = gruvbox_medium
beautiful.tasklist_fg_focus = gruvbox_text
beautiful.tasklist_fg_minimize = gruvbox_text
beautiful.systray_icon_spacing = 4

-- Open these programs on startup
open_startup_apps = true
if (open_startup_apps) then
    if (environment == "home") then
        awful.spawn("alacritty")
        awful.spawn("vivaldi")
        awful.spawn("thunderbird")
        awful.spawn("keepassxc")
        awful.spawn("dropbox start")
        awful.spawn("spotify")
        awful.spawn("steam")
        awful.spawn("discord")
    else
        awful.spawn("alacritty")
        awful.spawn("thunderbird")
        awful.spawn("keepassxc")
        awful.spawn("slack")
        awful.spawn("teams")
        awful.spawn("firefox")
        awful.spawn("prospect-mail")
    end
end


-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    {"hotkeys", function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end},
    {"manual", terminal .. " -e man awesome"},
    {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart},
    {"quit", function()
            awesome.quit()
        end}
}

local menu_awesome = {"awesome", myawesomemenu, beautiful.awesome_icon}
local menu_terminal = {"open terminal", terminal}

if has_fdo then
    mymainmenu =
        freedesktop.menu.build(
        {
            before = {menu_awesome},
            after = {menu_terminal}
        }
    )
else
    mymainmenu =
        awful.menu(
        {
            items = {
                menu_awesome,
                {"Debian", debian.menu.Debian_menu.Debian},
                menu_terminal
            }
        }
    )
end

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {modkey},
        1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button(
        {modkey},
        3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button(
        {},
        4,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),
    awful.button(
        {},
        5,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    )
)

local tasklist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end
    ),
    awful.button(
        {},
        3,
        function()
            awful.menu.client_list({theme = {width = 250}})
        end
    ),
    awful.button(
        {},
        4,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        {},
        5,
        function()
            awful.client.focus.byidx(-1)
        end
    )
)

local function set_wallpaper(s)
    -- Solid Color Wallpaper
    gears.wallpaper.set(gruvbox_dark)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
    function(s)
        -- Wallpaper
        set_wallpaper(s)

        -- Each screen has its own tag table.
        if (environment == "home") then
             awful.tag({"term", "web", "music", "mail", "pass", "steam", "discord", "8", "9"}, s, awful.layout.layouts[1])
	else
             awful.tag({"term", "web", "mail", "pass", "chat", "6", "7", "8", "9"}, s, awful.layout.layouts[2])
	end

        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create a taglist widget
        s.mytaglist =
            awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }

        -- Create a tasklist widget
        s.mytasklist =
            awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons
        }

        s.myseperator =
            wibox.widget {
            markup = " | ",
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox
        }

        -- Create the wibox
        s.mywibox =
            awful.wibar(
            {
                position = "top",
                screen = s,
                bg = gruvbox_dark,
                height = "15",
                fg = gruvbox_text
            }
        )

        -- Add widgets to the wibox
        if (environment == "home") then
            s.mywibox:setup {
                layout = wibox.layout.align.horizontal,
                {
                    -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    mylauncher,
                    s.mytaglist,
                    s.mypromptbox
                },
                s.mytasklist, -- Middle widget
                {
                    -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    wibox.widget.systray(),
                    s.myseperator,
                    spotify_widget({
                        font = 'Terminus 12'
                    }),
                    s.myseperator,
                    awful.widget.watch(
                        'bash -c "sensors | grep Tctl | awk \'{print $2}\'"',
                        15
                    ),
                    s.myseperator,
                    awful.widget.watch(
                        'bash -c "nvidia-smi -q -d temperature | grep \'GPU Current Temp\' | awk \'{print $5$6}\'"',
                        15
                    ),
                    s.myseperator,
                    awful.widget.watch(
                        'bash -c "nmcli d wifi | grep \'*\' | awk -v char=% \'{print $9char}\'"',
                        15
                    ),
                    s.myseperator,
                    awful.widget.watch(
                        'bash -c "uptime | sed -n -e \'s/^.*load average: //p\' | awk \'{print $1}\' | sed \'s/,*$//g\'"',
                        30
                    ),
                    s.myseperator,
                    awful.widget.watch(
                        'bash -c "free -h | awk \'/^Mem/ {print $3}\'"',
                        30
                    ),
                    s.myseperator,
                    wibox.widget.textclock(
                        "%Y-%m-%d %X",
                        1
                    ),
                    s.mylayoutbox
                }
            }
	else
            s.mywibox:setup {
                layout = wibox.layout.align.horizontal,
                {
                    -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    mylauncher,
                    s.mytaglist,
                    s.mypromptbox
                },
                s.mytasklist, -- Middle widget
                {
                    -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    wibox.widget.systray(),
                    s.myseperator,
                    awful.widget.watch(
	    	        'bash -c "sensors | grep Package | awk \'{print $4}\'"',
	    	        15
	    	    ),
                    s.myseperator,
                    awful.widget.watch(
	    	        'bash -c "nmcli d wifi | grep \'*\' | awk -v char=% \'{print $8char}\'"',
	    	        15
	    	    ),
                    s.myseperator,
                    awful.widget.watch(
                        'bash -c "uptime | sed -n -e \'s/^.*load average: //p\' | awk \'{print $1}\' | sed \'s/,*$//g\'"',
                        30
                    ),
                    s.myseperator,
                    awful.widget.watch(
	    	        'bash -c "free -h | awk \'/^Mem/ {print $3}\'"',
	    	        30
	    	    ),
                    s.myseperator,
	    	    awful.widget.watch(
	    	        'bash -c "upower -i $(upower -e | grep \'BAT\') | grep percentage | awk -v char=B: \'{print char$2}\'"',
	    	        30
	    	    ),
                    s.myseperator,
                    wibox.widget.textclock(
                        "%Y-%m-%d %X",
                        1
                    ),
                    s.mylayoutbox
                }
            }
	end
    end
)
-- }}}

-- {{{ Mouse bindings
root.buttons(
    gears.table.join(
        awful.button(
            {},
            3,
            function()
                mymainmenu:toggle()
            end
        ),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    )
)
-- }}}

-- {{{ Key bindings
globalkeys =
    gears.table.join(
    awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
    awful.key({modkey}, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({modkey}, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
    awful.key({modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),
    awful.key(
        {modkey},
        "j",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        {modkey},
        "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key(
        {modkey},
        "w",
        function()
            mymainmenu:show()
        end,
        {description = "show main menu", group = "awesome"}
    ),
    -- Layout manipulation
    awful.key(
        {modkey, "Shift"},
        "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap with previous client by index", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "j",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        {modkey, "Control"},
        "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key({modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
    awful.key(
        {modkey},
        "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),
    -- Standard program
    awful.key(
        {modkey},
        "Return",
        function()
            awful.spawn(terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key({modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
    awful.key(
        {modkey},
        "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key(
        {modkey},
        "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key(
        {modkey, "Shift"},
        "h",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key(
        {modkey, "Shift"},
        "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key(
        {modkey, "Control"},
        "h",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key(
        {modkey, "Control"},
        "l",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key(
        {modkey},
        "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    awful.key(
        {modkey, "Shift"},
        "space",
        function()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),
    awful.key(
        {modkey, "Control"},
        "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
        {description = "restore minimized", group = "client"}
    ),
    -- Prompt
    awful.key(
        {modkey},
        "r",
        function()
            awful.screen.focused().mypromptbox:run()
        end,
        {description = "run prompt", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "x",
        function()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}
    ),
    -- Menubar
    awful.key(
        {modkey},
        "p",
        function()
            menubar.show()
        end,
        {description = "show the menubar", group = "launcher"}
    ),
    -- Custom Bindings
    awful.key(
        {modkey},
        "l",
        function()
            awful.spawn("i3lock-fancy -g")
        end,
        {description = "Lock the screen", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "h",
        function()
            awful.spawn.with_shell("systemctl suspend; i3lock-fancy -g -- scrot -z;")
        end,
        {description = "Suspend the machine", group = "launcher"}
    )
)

clientkeys =
    gears.table.join(
    awful.key(
        {modkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "c",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = "client"}
    ),
    awful.key(
        {modkey},
        "o",
        function(c)
            c:move_to_screen()
        end,
        {description = "move to screen", group = "client"}
    ),
    awful.key(
        {modkey},
        "t",
        function(c)
            c.ontop = not c.ontop
        end,
        {description = "toggle keep on top", group = "client"}
    ),
    awful.key(
        {modkey},
        "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),
    awful.key(
        {modkey},
        "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys =
        gears.table.join(
        globalkeys,
        -- View tag only.
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, "Control"},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            {modkey, "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #" .. i, group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, "Control", "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end

clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        {modkey},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {modkey},
        3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
if (environment == "home") then
    awful.rules.rules = {
        -- All clients will match this rule.
        {
            rule = {},
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen
            }
        },
        -- Floating clients.
        {
            rule_any = {
                instance = {
                    "DTA", -- Firefox addon DownThemAll.
                    "copyq", -- Includes session name in class.
                    "pinentry"
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Gpick",
                    "Kruler",
                    "MessageWin", -- kalarm.
                    "Sxiv",
                    "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                    "Wpa_gui",
                    "veromix",
                    "xtightvncviewer"
                },
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Event Tester" -- xev.
                },
                role = {
                    "AlarmWindow", -- Thunderbird's calendar.
                    "ConfigManager", -- Thunderbird's about:config.
                    "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {floating = true}
        },
        {
            rule = {class = "Vivaldi-stable"},
            properties = {tag = "web", maximize = true}
        },
        {
            rule = {class = "Alacritty"},
            properties = {tag = "term", maximize = true}
        },
        {
            rule_any = {class = {"thunderbird", "Mail"}},
            properties = {tag = "mail", maximize = true}
        },
        {
            rule = {class = "KeePassXC"},
            properties = {tag = "pass", maximize = true}
        },
        {
            rule = {class = "Spotify"},
            properties = {tag = "music", maximize = true}
        },
        {
            rule = {class = "Steam"},
            properties = {tag = "steam", maximize = true}
        },
        {
            rule = {class = "discord"},
            properties = {tag = "discord", maximize = true}
        }
    }
else
    awful.rules.rules = {
        -- All clients will match this rule.
        {
            rule = {},
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen
            }
        },
        -- Floating clients.
        {
            rule_any = {
                instance = {
                    "DTA", -- Firefox addon DownThemAll.
                    "copyq", -- Includes session name in class.
                    "pinentry"
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Gpick",
                    "Kruler",
                    "MessageWin", -- kalarm.
                    "Sxiv",
                    "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                    "Wpa_gui",
                    "veromix",
                    "xtightvncviewer"
                },
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Event Tester" -- xev.
                },
                role = {
                    "AlarmWindow", -- Thunderbird's calendar.
                    "ConfigManager", -- Thunderbird's about:config.
                    "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {floating = true}
        },
        {
            rule = {class = "firefox"},
            properties = {
                tag = "web",
                maximize = true
        }
        },
        {
            rule = {class = "Alacritty"},
            properties = {
                tag = "term",
                maximize = true
        }
        },
        {
            rule_any = {class = {"thunderbird", "Mail"}},
            properties = {
                tag = "mail",
                maximized_vertical = true,
                width = 1280,
                placement = awful.placement.left
        }
        },
        {
            rule = {class = "Prospect Mail"},
            properties = {
                tag = "mail",
                maximized_vertical = true,
                width = 1280,
                placement = awful.placement.right
        }
        },
        {
            rule = {class = "KeePassXC"},
            properties = {
                tag = "pass",
                maximize = true
        }
        },
        {
            rule = {class = "Slack"},
            properties = {
                tag = "chat",
                maximized_vertical = true,
                width = 960,
                placement = awful.placement.left
        }
        },
        {
            rule = {class = "Microsoft Teams - Preview"},
            properties = {
                tag = "chat",
                maximized_vertical = true,
                width = 960,
                placement = awful.placement.right
        }
        }
    }
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end
)

client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)
-- }}}

