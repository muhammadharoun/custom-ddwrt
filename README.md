# DD-WRT Hotspot UI Injection

هذا المشروع يضيف صفحة مخصصة داخل واجهة DD-WRT بدون تعديل الـ firmware نفسه.

## ماذا يفعل؟
- يحقن صفحة جديدة داخل الويب على المسار `/hotspot.asp`
- يحفظ `USER` و `PASS`
- ينشئ سكربت `/tmp/check_hotspot.sh`
- يمكن تشغيل السكربت من cron لإعادة تسجيل الدخول للهوتسبوت عند انقطاع الإنترنت
- كل الملفات تعمل من `/tmp` لذلك يتم إعادة إنشائها عند كل reboot عبر Startup Script

## الملفات
- `hotspot.asp` : صفحة الإدخال
- `applyuser.cgi` : معالج الحفظ وإنشاء السكربت
- `install_startup.sh` : سكربت Startup لتحميل الملفات من GitHub إلى الراوتر
- `check_hotspot_template.sh` : قالب مرجعي للسكريبت الذي يتم إنشاؤه داخل الراوتر

## طريقة الاستخدام

### 1) ارفع الملفات على GitHub
ارفع الملفات كما هي داخل مستودع عام، ثم خذ الرابط الخام Raw لكل ملف.

مثال:
- `https://raw.githubusercontent.com/USERNAME/REPO/main/hotspot.asp`
- `https://raw.githubusercontent.com/USERNAME/REPO/main/applyuser.cgi`

### 2) عدّل روابط التحميل داخل `install_startup.sh`
بدّل:
- `YOUR_RAW_BASE`

ليصبح مثلاً:
- `https://raw.githubusercontent.com/abdullahharoon/ddwrt-hotspot/main`

### 3) داخل DD-WRT
اذهب إلى:
- `Administration -> Commands`

الصق محتوى `install_startup.sh` بعد تعديل الروابط، ثم اضغط:
- `Save Startup`

### 4) أعد تشغيل الراوتر أو شغّل الأوامر يدويًا
بعدها افتح:
- `http://ROUTER-IP/hotspot.asp`

## ملاحظات مهمة
- هذا الحل مخصص لراوتر عليه DD-WRT مسبقًا
- يعتمد على `/tmp/www` لأنه writable
- الملفات تُحذف بعد reboot لذلك Startup Script مهم جدًا
- يفضّل تفعيل:
  - `Cron`
  - وإضافة:
    `*/1 * * * * root /tmp/check_hotspot.sh`

## تنبيه أمني
البيانات تُحفظ داخل `/tmp/hotspot.conf` بصلاحيات محدودة، لكن هذا ليس نظام صلاحيات متقدم.
استخدمه فقط داخل شبكة موثوقة، ولا تفعّل الوصول الخارجي للـ Web GUI إلا عند الضرورة.
