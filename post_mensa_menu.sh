#!/bin/bash
set -euo pipefail

kw=$(date +%V)
dow=$(date +%u)

mri_url='https://casinocatering.de/speiseplan/'
mensa_url='https://www.sw-ka.de/de/essen/?view=ok&STYLE=popup_plain&c=adenauerring&p=1&kw='$kw

food_mri=$(xsltproc --html --novalid --param dow $dow mri.xslt <(curl "${mri_url}"))
food_mensa=$(xsltproc --html --novalid mensa.xslt <(curl "${mensa_url}"))

last_message_id="$(cat /var/local/lib/mensabot_last_message_id)"

curl -X PUT -H "Authorization: Bearer ${BOT_TOKEN}" -H 'Content-Type: application/json' -d '{"is_pinned":false}' ${MM_URL}/api/v4/posts/"${last_message_id}"/patch

message='{"channel_id":"'"${MM_CHANNEL_ID}"'", "is_pinned":true, "message":"'Mentions:\\n"${MM_MENTIONS}"\\nMRI\\n\\n"${food_mri}"\\n\\nMensa\\n\\n"${food_mensa}"'"}'
echo $message | curl -X POST -H "Authorization: Bearer ${BOT_TOKEN}" -H 'Content-Type: application/json' -d @- ${MM_URL}/api/v4/posts | jq -r ".id" > /var/local/lib/mensabot_last_message_id
