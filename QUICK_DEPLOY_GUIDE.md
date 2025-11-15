# SCOR-RISK Game - دليل النشر السريع

## الطريقة الأسرع: استخدام السكريبت الجاهز

### على Linux/Mac:

```bash
# 1. جعل السكريبت قابلاً للتنفيذ
chmod +x deploy-to-netlify.sh

# 2. تشغيل السكريبت
./deploy-to-netlify.sh

# السكريبت سيقوم بـ:
# ✅ التحقق من المتطلبات
# ✅ تسجيل الدخول إلى Netlify
# ✅ طلب معلومات الموقع
# ✅ إعداد جميع متغيرات البيئة تفاعلياً
# ✅ بناء المشروع
# ✅ نشر الموقع
```

### على Windows (PowerShell):

```powershell
# 1. تثبيت المتطلبات
npm install -g netlify-cli pnpm

# 2. تسجيل الدخول
netlify login

# 3. الانتقال إلى مجلد المشروع
cd C:\path\to\scor_risk_game

# 4. بناء المشروع
pnpm install
pnpm build

# 5. نشر الموقع
netlify deploy --prod --dir=dist/public
```

---

## الأوامر الأساسية

### 1. التثبيت الأولي

```bash
# تثبيت Netlify CLI
npm install -g netlify-cli

# التحقق من التثبيت
netlify --version
```

### 2. تسجيل الدخول

```bash
# تسجيل الدخول إلى Netlify
netlify login

# التحقق من حالة تسجيل الدخول
netlify status
```

### 3. إعداد متغيرات البيئة

```bash
# عرض الموقع الخاص بك
netlify sites:list

# إعداد متغير بيئة واحد
netlify env:set DATABASE_URL "mysql://user:pass@host/db"

# إعداد عدة متغيرات
netlify env:set JWT_SECRET "your-secret-key"
netlify env:set VITE_APP_ID "your-app-id"
netlify env:set VITE_APP_TITLE "SCOR-RISK Game"

# عرض جميع المتغيرات
netlify env:list

# حذف متغير
netlify env:unset VARIABLE_NAME
```

### 4. البناء والنشر

```bash
# بناء المشروع
pnpm install
pnpm build

# نشر الموقع
netlify deploy --prod --dir=dist/public

# نشر معاين (بدون تعيين كإصدار نهائي)
netlify deploy --dir=dist/public
```

### 5. التحقق والإدارة

```bash
# عرض معلومات الموقع
netlify sites:list

# فتح لوحة التحكم
netlify open:admin

# فتح الموقع المباشر
netlify open

# عرض سجلات البناء
netlify logs:build

# عرض سجلات الدوال
netlify logs:functions
```

---

## متغيرات البيئة المطلوبة (الحد الأدنى)

```bash
# إجباري
netlify env:set NODE_ENV "production"
netlify env:set DATABASE_URL "mysql://user:pass@host/db"
netlify env:set JWT_SECRET "$(openssl rand -base64 32)"
netlify env:set VITE_APP_ID "your_app_id"
netlify env:set VITE_APP_TITLE "SCOR-RISK Simulation Game"
netlify env:set VITE_APP_LOGO "/logo.png"
netlify env:set OAUTH_SERVER_URL "https://oauth.example.com"
netlify env:set VITE_OAUTH_PORTAL_URL "https://portal.example.com"
netlify env:set OWNER_OPEN_ID "your_owner_id"
netlify env:set OWNER_NAME "Your Name"
netlify env:set BUILT_IN_FORGE_API_URL "https://api.example.com"
netlify env:set BUILT_IN_FORGE_API_KEY "your_api_key"
netlify env:set VITE_FRONTEND_FORGE_API_URL "https://api.example.com"
netlify env:set VITE_FRONTEND_FORGE_API_KEY "your_frontend_key"

# اختياري
netlify env:set VITE_ANALYTICS_ENDPOINT "https://analytics.example.com"
netlify env:set VITE_ANALYTICS_WEBSITE_ID "your_analytics_id"
```

---

## أمر واحد يفعل كل شيء

```bash
# نسخ هذا الأمر واستخدمه مباشرة
cd /path/to/scor_risk_game && \
pnpm install && \
pnpm build && \
netlify deploy --prod --dir=dist/public
```

---

## استكشاف الأخطاء

| المشكلة | الحل |
|--------|------|
| "netlify: command not found" | `npm install -g netlify-cli` |
| "Build failed" | `netlify logs:build` لعرض التفاصيل |
| "Cannot find module" | `pnpm install` ثم `pnpm build` |
| "Database connection failed" | تحقق من `DATABASE_URL` صحيح |
| "Blank page" | امسح الكاش (Ctrl+Shift+Delete) |

---

## نصائح مهمة

1. **JWT_SECRET**: استخدم قيمة عشوائية قوية
   ```bash
   openssl rand -base64 32
   ```

2. **API Keys**: لا تشارك مفاتيحك
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
