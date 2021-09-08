# mensabot

This code fetches, parses and posts the daily mensa menus of the "Mensa am Adenauerring" and "MRI" to Mattermost.

Execute `./post_mensa_menu.sh` with the environment variables `MM_CHANNEL_ID`, `BOT_TOKEN` and `MM_URL` set appropriately.

Since the menus won't be cached, don't execute this script too frequently (The menu changes only once a day anyways).
