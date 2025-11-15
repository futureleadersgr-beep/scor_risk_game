#!/bin/bash

################################################################################
# SCOR-RISK Game - Netlify CLI Deployment Script
# أمر نشر شامل إلى Netlify مع إعداد متغيرات البيئة
################################################################################

set -e  # Exit on error

# الألوان للطباعة
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# دوال مساعدة
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️ $1${NC}"
}

################################################################################
# 1. التحقق من المتطلبات
################################################################################

print_header "التحقق من المتطلبات"

# التحقق من Node.js
if ! command -v node &> /dev/null; then
    print_error "Node.js غير مثبت. يرجى تثبيت Node.js من https://nodejs.org/"
    exit 1
fi
print_success "Node.js مثبت: $(node --version)"

# التحقق من npm
if ! command -v npm &> /dev/null; then
    print_error "npm غير مثبت"
    exit 1
fi
print_success "npm مثبت: $(npm --version)"

# التحقق من pnpm
if ! command -v pnpm &> /dev/null; then
    print_warning "pnpm غير مثبت. جاري التثبيت..."
    npm install -g pnpm
fi
print_success "pnpm مثبت: $(pnpm --version)"

# التحقق من Netlify CLI
if ! command -v netlify &> /dev/null; then
    print_warning "Netlify CLI غير مثبت. جاري التثبيت..."
    npm install -g netlify-cli
fi
print_success "Netlify CLI مثبت: $(netlify --version)"

################################################################################
# 2. تسجيل الدخول إلى Netlify
################################################################################

print_header "تسجيل الدخول إلى Netlify"

# التحقق من وجود حساب مسجل
if ! netlify status &> /dev/null; then
    print_info "يرجى تسجيل الدخول إلى حسابك على Netlify..."
    netlify login
else
    print_success "أنت مسجل الدخول بالفعل"
fi

################################################################################
# 3. إعداد متغيرات البيئة
################################################################################

print_header "إعداد متغيرات البيئة"

# الحصول على معلومات الموقع
print_info "اختر موقعك على Netlify:"
netlify sites:list

print_warning "أدخل معرّف الموقع (Site ID) من القائمة أعلاه:"
read -p "Site ID: " SITE_ID

if [ -z "$SITE_ID" ]; then
    print_error "لم يتم إدخال معرّف الموقع"
    exit 1
fi

print_info "سيتم الآن إعداد متغيرات البيئة للموقع: $SITE_ID"

# قاعدة البيانات
print_warning "أدخل رابط قاعدة البيانات (Database URL):"
print_info "الصيغة: mysql://username:password@host:port/database"
read -p "DATABASE_URL: " DATABASE_URL

if [ -z "$DATABASE_URL" ]; then
    print_warning "تم تخطي DATABASE_URL"
else
    netlify env:set --site="$SITE_ID" DATABASE_URL "$DATABASE_URL"
    print_success "تم إعداد DATABASE_URL"
fi

# JWT Secret
print_info "جاري إنشاء JWT_SECRET عشوائي قوي..."
JWT_SECRET=$(openssl rand -base64 32)
netlify env:set --site="$SITE_ID" JWT_SECRET "$JWT_SECRET"
print_success "تم إعداد JWT_SECRET"

# معرّف التطبيق
print_warning "أدخل معرّف التطبيق (App ID):"
read -p "VITE_APP_ID: " APP_ID

if [ -z "$APP_ID" ]; then
    print_warning "تم تخطي VITE_APP_ID"
else
    netlify env:set --site="$SITE_ID" VITE_APP_ID "$APP_ID"
    print_success "تم إعداد VITE_APP_ID"
fi

# عنوان التطبيق
netlify env:set --site="$SITE_ID" VITE_APP_TITLE "SCOR-RISK Simulation Game"
print_success "تم إعداد VITE_APP_TITLE"

# شعار التطبيق
netlify env:set --site="$SITE_ID" VITE_APP_LOGO "/logo.png"
print_success "تم إعداد VITE_APP_LOGO"

# OAuth Server
print_warning "أدخل رابط خادم OAuth:"
read -p "OAUTH_SERVER_URL: " OAUTH_SERVER_URL

if [ -z "$OAUTH_SERVER_URL" ]; then
    print_warning "تم تخطي OAUTH_SERVER_URL"
else
    netlify env:set --site="$SITE_ID" OAUTH_SERVER_URL "$OAUTH_SERVER_URL"
    print_success "تم إعداد OAUTH_SERVER_URL"
fi

# OAuth Portal
print_warning "أدخل رابط بوابة OAuth:"
read -p "VITE_OAUTH_PORTAL_URL: " OAUTH_PORTAL_URL

if [ -z "$OAUTH_PORTAL_URL" ]; then
    print_warning "تم تخطي VITE_OAUTH_PORTAL_URL"
else
    netlify env:set --site="$SITE_ID" VITE_OAUTH_PORTAL_URL "$OAUTH_PORTAL_URL"
    print_success "تم إعداد VITE_OAUTH_PORTAL_URL"
fi

# معرّف المالك
print_warning "أدخل معرّف المالك (Owner Open ID):"
read -p "OWNER_OPEN_ID: " OWNER_OPEN_ID

if [ -z "$OWNER_OPEN_ID" ]; then
    print_warning "تم تخطي OWNER_OPEN_ID"
else
    netlify env:set --site="$SITE_ID" OWNER_OPEN_ID "$OWNER_OPEN_ID"
    print_success "تم إعداد OWNER_OPEN_ID"
fi

# اسم المالك
print_warning "أدخل اسم المالك:"
read -p "OWNER_NAME: " OWNER_NAME

if [ -z "$OWNER_NAME" ]; then
    print_warning "تم تخطي OWNER_NAME"
else
    netlify env:set --site="$SITE_ID" OWNER_NAME "$OWNER_NAME"
    print_success "تم إعداد OWNER_NAME"
fi

# Forge API URL
print_warning "أدخل رابط Forge API:"
read -p "BUILT_IN_FORGE_API_URL: " FORGE_API_URL

if [ -z "$FORGE_API_URL" ]; then
    print_warning "تم تخطي BUILT_IN_FORGE_API_URL"
else
    netlify env:set --site="$SITE_ID" BUILT_IN_FORGE_API_URL "$FORGE_API_URL"
    print_success "تم إعداد BUILT_IN_FORGE_API_URL"
fi

# Forge API Key
print_warning "أدخل مفتاح Forge API:"
read -p "BUILT_IN_FORGE_API_KEY: " FORGE_API_KEY

if [ -z "$FORGE_API_KEY" ]; then
    print_warning "تم تخطي BUILT_IN_FORGE_API_KEY"
else
    netlify env:set --site="$SITE_ID" BUILT_IN_FORGE_API_KEY "$FORGE_API_KEY"
    print_success "تم إعداد BUILT_IN_FORGE_API_KEY"
fi

# Frontend Forge API URL
netlify env:set --site="$SITE_ID" VITE_FRONTEND_FORGE_API_URL "${FORGE_API_URL:-https://api.example.com}"
print_success "تم إعداد VITE_FRONTEND_FORGE_API_URL"

# Frontend Forge API Key
netlify env:set --site="$SITE_ID" VITE_FRONTEND_FORGE_API_KEY "${FORGE_API_KEY:-default_key}"
print_success "تم إعداد VITE_FRONTEND_FORGE_API_KEY"

# Analytics (اختياري)
print_warning "أدخل نقطة نهاية التحليلات (اختياري):"
read -p "VITE_ANALYTICS_ENDPOINT: " ANALYTICS_ENDPOINT

if [ -n "$ANALYTICS_ENDPOINT" ]; then
    netlify env:set --site="$SITE_ID" VITE_ANALYTICS_ENDPOINT "$ANALYTICS_ENDPOINT"
    print_success "تم إعداد VITE_ANALYTICS_ENDPOINT"
fi

print_warning "أدخل معرّف الموقع للتحليلات (اختياري):"
read -p "VITE_ANALYTICS_WEBSITE_ID: " ANALYTICS_ID

if [ -n "$ANALYTICS_ID" ]; then
    netlify env:set --site="$SITE_ID" VITE_ANALYTICS_WEBSITE_ID "$ANALYTICS_ID"
    print_success "تم إعداد VITE_ANALYTICS_WEBSITE_ID"
fi

################################################################################
# 4. بناء المشروع
################################################################################

print_header "بناء المشروع"

print_info "جاري تثبيت المكتبات..."
pnpm install

print_info "جاري بناء المشروع..."
pnpm build

if [ ! -d "dist/public" ]; then
    print_error "فشل البناء: لم يتم إنشاء مجلد dist/public"
    exit 1
fi

print_success "تم بناء المشروع بنجاح"

################################################################################
# 5. نشر الموقع
################################################################################

print_header "نشر الموقع إلى Netlify"

print_info "جاري نشر الموقع..."
netlify deploy --prod --site="$SITE_ID" --dir=dist/public

################################################################################
# 6. التحقق من النشر
################################################################################

print_header "التحقق من النشر"

print_info "معلومات الموقع:"
netlify sites:list | grep "$SITE_ID"

print_info "متغيرات البيئة المعيّنة:"
netlify env:list --site="$SITE_ID"

################################################################################
# 7. الخطوات النهائية
################################################################################

print_header "اكتمل النشر بنجاح! 🎉"

print_success "الموقع متاح الآن"
print_info "يمكنك فتح لوحة التحكم بالأمر التالي:"
echo "  netlify open:admin --site=$SITE_ID"

print_info "أو فتح الموقع مباشرة:"
echo "  netlify open --site=$SITE_ID"

print_info "لعرض السجلات:"
echo "  netlify logs:build --site=$SITE_ID"

################################################################################
# النهاية
################################################################################

print_success "شكراً لاستخدام SCOR-RISK Game!"
