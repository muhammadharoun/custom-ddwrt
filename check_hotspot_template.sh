#!/bin/sh

# هذا ملف مرجعي فقط
# النسخة الفعلية سيتم توليدها داخل الراوتر بعد حفظ البيانات من الواجهة

CONF_FILE="/tmp/hotspot.conf"

[ -f "$CONF_FILE" ] || exit 1
. "$CONF_FILE"

ping -c 2 8.8.8.8 >/dev/null 2>&1
if [ $? -ne 0 ]; then
    wget -q -O /tmp/hotspot_login.html "$LOGIN_URL?dst=&popup=true&username=$USER&password=$PASS"
fi
