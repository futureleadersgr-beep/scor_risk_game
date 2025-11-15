# SCOR-RISK Game - Netlify CLI Deployment Script الكامل

## المتطلبات الأساسية

```bash
# 1. تثبيت Node.js (إذا لم يكن مثبتاً)
# تحميل من: https://nodejs.org/

# 2. تثبيت Netlify CLI
npm install -g netlify-cli

# 3. التحقق من التثبيت
netlify --version
```

---

## خطوات النشر الكاملة

### الخطوة 1: تسجيل الدخول إلى Netlify

```bash
# تسجيل الدخول إلى حسابك على Netlify
netlify login

# سيفتح متصفح لتسجيل الدخول
# بعد التسجيل، سيتم حفظ بيانات الاعتماد محلياً
```

---

### الخطوة 2: إعداد متغيرات البيئة

قبل النشر، يجب إعداد جميع متغيرات البيئة المطلوبة. هناك طريقتان:

#### الطريقة أ: إنشاء ملف `.env.production`

```bash
# انتقل إلى مجلد المشروع
cd /path/to/scor_risk_game

# أنشئ ملف .env.production
cat > .env.production << 'EOF'
# Node Environment
NODE_ENV=production

# Database Configuration
DATABASE_URL=your_database_url_here

# JWT Secret for Session Cookies
JWT_SECRET=your_jwt_secret_here_min_32_characters

# OAuth Configuration
VITE_APP_ID=your_app_id_here
OAUTH_SERVER_URL=https://oauth.example.com
VITE_OAUTH_PORTAL_URL=https://portal.example.com

# Owner Information
OWNER_OPEN_ID=your_owner_open_id
OWNER_NAME=Your Name

# Manus Built-in APIs
BUILT_IN_FORGE_API_URL=https://api.example.com
BUILT_IN_FORGE_API_KEY=your_forge_api_key_here

# Frontend Configuration
VITE_FRONTEND_FORGE_API_URL=https://api.example.com
VITE_FRONTEND_FORGE_API_KEY=your_frontend_api_key_here

# App Configuration
VITE_APP_TITLE=SCOR-RISK Simulation Game
VITE_APP_LOGO=/logo.png

# Analytics (Optional)
VITE_ANALYTICS_ENDPOINT=https://analytics.example.com
VITE_ANALYTICS_WEBSITE_ID=your_website_id
EOF
```

#### الطريقة ب: إعداد المتغيرات مباشرة عبر Netlify CLI

```bash
# سيتم شرح هذا في الخطوة التالية
```

---

### الخطوة 3: أمر النشر الكامل

#### الخيار 1: النشر البسيط (بدون متغيرات بيئة)

```bash
# انتقل إلى مجلد المشروع
cd /path/to/scor_risk_game

# نشر الموقع
netlify deploy --prod --dir=dist/public

# سيُطلب منك:
# 1. اختيار موقع جديد أو موقع موجود
# 2. تأكيد المسار
# 3. انتظار اكتمال النشر
```

#### الخيار 2: النشر مع إعداد المتغيرات (موصى به)

```bash
#!/bin/bash
# save this as deploy.sh

cd /path/to/scor_risk_game

# 1. تسجيل الدخول
echo "تسجيل الدخول إلى Netlify..."
netlify login

# 2. إنشاء موقع جديد (إذا لم يكن موجوداً)
echo "إنشاء موقع جديد..."
netlify sites:create --name scor-risk-game

# 3. إعداد متغيرات البيئة
echo "إعداد متغيرات البيئة..."

# قاعدة البيانات
netlify env:set DATABASE_URL "mysql://user:password@host:3306/database"

# JWT Secret (استخدم قيمة عشوائية قوية)
netlify env:set JWT_SECRET "$(openssl rand -base64 32)"

# معرّفات التطبيق
netlify env:set VITE_APP_ID "your_app_id"
netlify env:set VITE_APP_TITLE "SCOR-RISK Simulation Game"
netlify env:set VITE_APP_LOGO "/logo.png"

# OAuth
netlify env:set OAUTH_SERVER_URL "https://oauth.example.com"
netlify env:set VITE_OAUTH_PORTAL_URL "https://portal.example.com"

# معلومات المالك
netlify env:set OWNER_OPEN_ID "your_owner_id"
netlify env:set OWNER_NAME "Your Name"

# Manus APIs
netlify env:set BUILT_IN_FORGE_API_URL "https://api.example.com"
netlify env:set BUILT_IN_FORGE_API_KEY "your_api_key"
netlify env:set VITE_FRONTEND_FORGE_API_URL "https://api.example.com"
netlify env:set VITE_FRONTEND_FORGE_API_KEY "your_frontend_key"

# Analytics (اختياري)
netlify env:set VITE_ANALYTICS_ENDPOINT "https://analytics.example.com"
netlify env:set VITE_ANALYTICS_WEBSITE_ID "your_analytics_id"

# 4. نشر الموقع
echo "نشر الموقع..."
netlify deploy --prod --dir=dist/public

echo "✅ تم النشر بنجاح!"
```

---

### الخطوة 4: تشغيل سكريبت النشر

```bash
# إذا كنت تستخدم Linux/Mac
chmod +x deploy.sh
./deploy.sh

# إذا كنت تستخدم Windows
# استخدم PowerShell أو Command Prompt وقم بتشغيل الأوامر يدوياً
```

---

## أمر النشر الكامل (نسخة واحدة)

إذا كنت تريد أمراً واحداً يفعل كل شيء:

```bash
#!/bin/bash

# تعريف المتغيرات
PROJECT_DIR="/path/to/scor_risk_game"
SITE_NAME="scor-risk-game"
DATABASE_URL="mysql://user:password@host:3306/database"
JWT_SECRET=$(openssl rand -base64 32)
APP_ID="your_app_id"
OAUTH_URL="https://oauth.example.com"
OWNER_ID="your_owner_id"
OWNER_NAME="Your Name"
FORGE_API_URL="https://api.example.com"
FORGE_API_KEY="your_api_key"

# الانتقال إلى مجلد المشروع
cd "$PROJECT_DIR"

# تسجيل الدخول
echo "🔐 تسجيل الدخول إلى Netlify..."
netlify login

# إنشاء الموقع
echo "🌐 إنشاء موقع جديد..."
netlify sites:create --name "$SITE_NAME"

# إعداد جميع متغيرات البيئة
echo "⚙️ إعداد متغيرات البيئة..."
netlify env:set NODE_ENV "production"
netlify env:set DATABASE_URL "$DATABASE_URL"
netlify env:set JWT_SECRET "$JWT_SECRET"
netlify env:set VITE_APP_ID "$APP_ID"
netlify env:set VITE_APP_TITLE "SCOR-RISK Simulation Game"
netlify env:set VITE_APP_LOGO "/logo.png"
netlify env:set OAUTH_SERVER_URL "$OAUTH_URL"
netlify env:set VITE_OAUTH_PORTAL_URL "$OAUTH_URL"
netlify env:set OWNER_OPEN_ID "$OWNER_ID"
netlify env:set OWNER_NAME "$OWNER_NAME"
netlify env:set BUILT_IN_FORGE_API_URL "$FORGE_API_URL"
netlify env:set BUILT_IN_FORGE_API_KEY "$FORGE_API_KEY"
netlify env:set VITE_FRONTEND_FORGE_API_URL "$FORGE_API_URL"
netlify env:set VITE_FRONTEND_FORGE_API_KEY "$FORGE_API_KEY"

# بناء المشروع
echo "🔨 بناء المشروع..."
pnpm install
pnpm build

# نشر الموقع
echo "🚀 نشر الموقع..."
netlify deploy --prod --dir=dist/public

echo "✅ تم النشر بنجاح!"
echo "🌍 الموقع متاح على: https://$SITE_NAME.netlify.app"
```

---

## متغيرات البيئة المطلوبة - شرح مفصل

| المتغير | الوصف | مثال | مطلوب |
|--------|-------|------|-------|
| `NODE_ENV` | بيئة التشغيل | `production` | ✅ |
| `DATABASE_URL` | رابط قاعدة البيانات | `mysql://user:pass@host/db` | ✅ |
| `JWT_SECRET` | مفتاح التشفير (32+ حرف) | `abc123...` | ✅ |
| `VITE_APP_ID` | معرّف التطبيق | `app_12345` | ✅ |
| `VITE_APP_TITLE` | اسم التطبيق | `SCOR-RISK Game` | ✅ |
| `VITE_APP_LOGO` | رابط الشعار | `/logo.png` | ✅ |
| `OAUTH_SERVER_URL` | خادم OAuth | `https://oauth.example.com` | ✅ |
| `VITE_OAUTH_PORTAL_URL` | بوابة OAuth | `https://portal.example.com` | ✅ |
| `OWNER_OPEN_ID` | معرّف المالك | `owner_123` | ✅ |
| `OWNER_NAME` | اسم المالك | `Ahmed` | ✅ |
| `BUILT_IN_FORGE_API_URL` | رابط Forge API | `https://api.example.com` | ✅ |
| `BUILT_IN_FORGE_API_KEY` | مفتاح Forge API | `key_123...` | ✅ |
| `VITE_FRONTEND_FORGE_API_URL` | رابط Frontend API | `https://api.example.com` | ✅ |
| `VITE_FRONTEND_FORGE_API_KEY` | مفتاح Frontend API | `key_456...` | ✅ |
| `VITE_ANALYTICS_ENDPOINT` | نقطة نهاية التحليلات | `https://analytics.example.com` | ❌ |
| `VITE_ANALYTICS_WEBSITE_ID` | معرّف الموقع | `site_123` | ❌ |

---

## التحقق من النشر

```bash
# عرض حالة النشر
netlify status

# عرض معلومات الموقع
netlify sites:list

# عرض متغيرات البيئة
netlify env:list

# عرض سجلات البناء
netlify logs:build

# عرض سجلات الدوال
netlify logs:functions
```

---

## استكشاف الأخطاء

### الخطأ: "Build failed"

```bash
# تحقق من السجلات
netlify logs:build

# تأكد من وجود جميع المتغيرات
netlify env:list

# أعد النشر
netlify deploy --prod --dir=dist/public
```

### الخطأ: "Cannot find module"

```bash
# تأكد من تثبيت المكتبات
pnpm install

# أعد البناء
pnpm build

# تحقق من المسار
ls -la dist/public/
```

### الخطأ: "Database connection failed"

```bash
# تحقق من متغير DATABASE_URL
netlify env:get DATABASE_URL

# تأكد من صحة رابط الاتصال
# الصيغة: mysql://username:password@host:port/database
```

---

## نصائح مهمة

1. **JWT_SECRET**: استخدم قيمة عشوائية قوية (32+ حرف)
   ```bash
   openssl rand -base64 32
   ```

2. **API Keys**: لا تشارك مفاتيحك العامة
   - استخدم متغيرات البيئة فقط
   - لا تضعها في الكود

3. **قاعدة البيانات**: تأكد من:
   - الاتصال يعمل من خادم Netlify
   - الصلاحيات صحيحة
   - المنفذ مفتوح

4. **النسخ الاحتياطية**: احفظ نسخة من:
   - متغيرات البيئة
   - مفاتيح API
   - بيانات قاعدة البيانات

---

## أوامر مفيدة إضافية

```bash
# عرض جميع الأوامر المتاحة
netlify --help

# إعادة تعيين متغير بيئة
netlify env:unset VARIABLE_NAME

# نشر معاين (بدون تعيين كإصدار نهائي)
netlify deploy --dir=dist/public

# حذف الموقع
netlify sites:delete

# تشغيل الموقع محلياً
netlify dev

# فتح لوحة التحكم
netlify open:admin
```

---

## الخطوات النهائية

بعد النشر الناجح:

1. ✅ تحقق من الموقع على الرابط المعطى
2. ✅ اختبر جميع الميزات
3. ✅ أضف نطاق مخصص (اختياري)
4. ✅ فعّل HTTPS (تلقائي)
5. ✅ شارك الرابط مع المستخدمين

---

**الإصدار:** 1.0
**آخر تحديث:** نوفمبر 2025
**الحالة:** جاهز للإنتاج ✅
