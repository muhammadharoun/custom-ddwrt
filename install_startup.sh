#!/bin/sh
# DD-WRT Startup Installer
# عدّل السطر التالي إلى رابط Raw base الخاص بمستودع GitHub عندك
RAW_BASE="YOUR_RAW_BASE"

mkdir -p /tmp/www

wget -q -O /tmp/www/hotspot.asp "$RAW_BASE/hotspot.asp"
wget -q -O /tmp/www/applyuser.cgi "$RAW_BASE/applyuser.cgi"

chmod +x /tmp/www/applyuser.cgi

# إعادة تشغيل خادم الويب لالتقاط الملفات الجديدة
stopservice httpd
startservice httpd

# لو كانت بيانات الهوتسبوت موجودة سابقاً، أعد إنشاء سكربت الفحص
if [ -f /tmp/hotspot.conf ]; then
cat << 'EOF' > /tmp/check_hotspot.sh
#!/bin/sh

CONF_FILE="/tmp/hotspot.conf"

[ -f "$CONF_FILE" ] || exit 1
. "$CONF_FILE"

ping -c 2 8.8.8.8 >/dev/null 2>&1
if [ $? -ne 0 ]; then
    wget -q -O /tmp/hotspot_login.html "$LOGIN_URL?dst=&popup=true&username=$USER&password=$PASS"
fi
EOF
chmod +x /tmp/check_hotspot.sh
fi
