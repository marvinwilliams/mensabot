#!/bin/bash
set -euo pipefail

mensa_url='https://www.sw-ka.de/de/essen/?view=ok&STYLE=popup_plain&c=adenauerring&p=1&kw='$kw
mri_url='https://casinocatering.de/speiseplan/'

kw=$(date +%V)
dow=$(date +%u)

food_mensa=$(xsltproc --html --novalid mensa.xslt <(curl "${mensa_url}"))
food_mri=$(xsltproc --html --novalid --param dow $dow mri.xslt <(curl "${mri_url}"))

message='{"channel_id":"'"${MM_CHANNEL_ID}"'", "message":"'Mensa\\n\\n"${food_mensa}"\\n\\nMri\\n\\n"${food_mri}"'"}'
echo $message | curl -H "Authorization: Bearer ${BOT_TOKEN}" -H 'Content-Type: application/json' -d @- ${MM_URL}/api/v4/posts
