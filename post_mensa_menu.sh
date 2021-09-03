#!/bin/bash
set -euo pipefail

kw=$(date +%V)
dow=$(date +%u)

mri_url='https://casinocatering.de/speiseplan/'
mensa_url='https://www.sw-ka.de/de/essen/?view=ok&STYLE=popup_plain&c=adenauerring&p=1&kw='$kw

food_mri=$(xsltproc --html --novalid --param dow $dow mri.xslt <(curl "${mri_url}"))
food_mensa=$(xsltproc --html --novalid mensa.xslt <(curl "${mensa_url}"))

message='{"id":"'"${MM_POST_ID}"'", "is_pinned":true, "message":"'Mri\\n\\n"${food_mri}"\\n\\nMensa\\n\\n"${food_mensa}"'"}'
echo $message | curl -X PUT -H "Authorization: Bearer ${BOT_TOKEN}" -H 'Content-Type: application/json' -d @- ${MM_URL}/api/v4/posts/${MM_POST_ID}
