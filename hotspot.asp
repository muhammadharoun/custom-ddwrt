<html>
<head>
  <title>Haroon Hotspot Settings</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; background: #f7f7f7; color: #222; }
    .card { max-width: 560px; margin: 0 auto; background: #fff; padding: 24px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,.08); }
    h2 { margin-top: 0; }
    label { display: block; margin: 14px 0 6px; font-weight: bold; }
    input[type="text"], input[type="password"] {
      width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 8px; box-sizing: border-box;
    }
    button {
      margin-top: 18px; width: 100%; padding: 12px; border: 0; border-radius: 8px;
      background: #0b5ed7; color: white; font-size: 16px; cursor: pointer;
    }
    .note { margin-top: 14px; font-size: 13px; color: #666; line-height: 1.6; }
  </style>
</head>
<body>
  <div class="card">
    <h2>Haroon Hotspot Settings</h2>
    <form method="GET" action="/applyuser.cgi">
      <label for="USER">Hotspot Username</label>
      <input id="USER" type="text" name="USER" placeholder="e.g. 509198654493" required>

      <label for="PASS">Hotspot Password</label>
      <input id="PASS" type="password" name="PASS" placeholder="Enter hotspot password" required>

      <button type="submit">Save Settings</button>
    </form>

    <div class="note">
      بعد الحفظ سيتم إنشاء سكربت <code>/tmp/check_hotspot.sh</code><br>
      ويمكنك تشغيله من Cron لإعادة تسجيل الدخول تلقائيًا.
    </div>
  </div>
</body>
</html>
