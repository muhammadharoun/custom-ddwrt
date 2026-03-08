#!/bin/sh

echo "Content-type: text/html"
echo ""

url_decode() {
  local data="${1//+/ }"
  printf '%b' "${data//%/\\x}"
}

QUERY="$QUERY_STRING"
RAW_USER="$(echo "$QUERY" | sed -n 's/.*USER=\([^&]*\).*/\1/p')"
RAW_PASS="$(echo "$QUERY" | sed -n 's/.*PASS=\([^&]*\).*/\1/p')"

USER="$(url_decode "$RAW_USER")"
PASS="$(url_decode "$RAW_PASS")"

if [ -z "$USER" ] || [ -z "$PASS" ]; then
  cat << 'EOF'
<html><body>
<h2>Missing data</h2>
<p>USER or PASS is empty.</p>
<p><a href="/hotspot.asp">Back</a></p>
</body></html>
EOF
  exit 1
fi

cat << EOF > /tmp/hotspot.conf
USER="$USER"
PASS="$PASS"
LOGIN_URL="http://10.10.0.1/login"
EOF
chmod 600 /tmp/hotspot.conf

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

cat << EOF
<html>
<head>
  <title>Saved</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; background: #f7f7f7; color: #222; }
    .card { max-width: 560px; margin: 0 auto; background: #fff; padding: 24px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,.08); }
    a { color: #0b5ed7; text-decoration: none; }
    code { background: #f1f1f1; padding: 2px 6px; border-radius: 4px; }
  </style>
</head>
<body>
  <div class="card">
    <h2>Saved successfully</h2>
    <p>Hotspot credentials were saved.</p>
    <p>Created files:</p>
    <ul>
      <li><code>/tmp/hotspot.conf</code></li>
      <li><code>/tmp/check_hotspot.sh</code></li>
    </ul>
    <p>Next step: فعّل Cron وأضف السطر التالي:</p>
    <pre>*/1 * * * * root /tmp/check_hotspot.sh</pre>
    <p><a href="/hotspot.asp">Back to settings</a></p>
  </div>
</body>
</html>
EOF
