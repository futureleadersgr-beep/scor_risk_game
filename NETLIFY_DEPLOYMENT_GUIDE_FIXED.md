# SCOR-RISK Game - Netlify Deployment Guide (Fixed)

## ⚠️ Important: Use GitHub Method (Recommended)

The drag-and-drop method may fail because this project includes a backend server. **Use the GitHub method instead** for reliable deployment.

---

## Method 1: GitHub Integration (RECOMMENDED) ✅

### Step 1: Push to GitHub
```bash
# Initialize git (if not already done)
git init
git add .
git commit -m "SCOR-RISK Game - English Version"

# Create a new repository on GitHub.com
# Then push your code:
git remote add origin https://github.com/YOUR-USERNAME/scor-risk-game.git
git branch -M main
git push -u origin main
```

### Step 2: Connect to Netlify
1. Go to https://app.netlify.com
2. Click **"Add new site"** → **"Import an existing project"**
3. Choose **GitHub**
4. Authorize Netlify to access your GitHub account
5. Select your `scor-risk-game` repository
6. Click **Deploy**

### Step 3: Configure Build Settings (if needed)
- **Build command:** `pnpm install && pnpm build`
- **Publish directory:** `dist/public`
- Click **Deploy site**

**That's it!** Your game will be live in 2-5 minutes.

---

## Method 2: Netlify CLI (Alternative)

### Step 1: Install Netlify CLI
```bash
npm install -g netlify-cli
```

### Step 2: Deploy
```bash
cd scor_risk_game
netlify deploy --prod --dir=dist/public
```

### Step 3: Follow the prompts
- Authorize with your Netlify account
- Choose to create a new site or deploy to existing
- Wait for deployment to complete

---

## Method 3: Drag & Drop (May Fail - Not Recommended)

If you still want to try drag-and-drop:

1. Go to https://app.netlify.com
2. Click **"Add new site"** → **"Deploy manually"**
3. Extract the `scor_risk_game_netlify_deploy.zip` file
4. Drag the **`dist/public`** folder (NOT the entire extracted folder) into Netlify
5. Wait for deployment

**Note:** This method may fail due to backend requirements. Use GitHub method if this fails.

---

## Project Features

✅ **4 Industries with Specialized Scenarios**
- Food & Beverages (4 scenarios)
- Apparel & Fashion (5 scenarios)
- Electronics & Technology (4 scenarios)
- Logistics & Supply Chain Services (4 scenarios)

✅ **Advanced Features**
- 3D Interactive Supply Chain Visualization
- AI-Powered Analysis & Recommendations
- Interactive Training Mode for Food Safety
- Real-time KPI Dashboards
- Industry-Specific Leaderboards
- Comprehensive Performance Reports
- Public Access Mode (no login required for students)

✅ **Game Mechanics**
- Dynamic Scenario System
- Multi-Process Impact Analysis
- Scoring System Based on Cost, Time & Risk
- Process-Specific Feedback
- Strategic Decision Tracking

---

## Troubleshooting

### Issue: "Build failed" on Netlify
**Solution:** Use the GitHub method instead of drag-and-drop. The project requires proper build configuration that GitHub integration handles automatically.

### Issue: Blank page after deployment
**Solution:** 
1. Check browser console for errors (F12)
2. Verify that `dist/public` was deployed (not `dist/`)
3. Check Netlify build logs for errors

### Issue: "Cannot find module" errors
**Solution:** Ensure all files were extracted correctly and the entire `dist/` folder is included.

### Issue: Styling looks broken
**Solution:** Clear browser cache (Ctrl+Shift+Delete) and reload the page.

---

## After Deployment

### 1. Custom Domain
1. Go to **Site settings** → **Domain management**
2. Click **Add custom domain**
3. Follow DNS configuration instructions

### 2. Share Your Game
- Copy the Netlify URL (e.g., `https://scor-risk-game-abc123.netlify.app`)
- Share with students/users
- They can play without login using the public access mode

### 3. Monitor Performance
- Check **Analytics** in Netlify Dashboard
- Monitor build logs for any issues
- Set up notifications for deployment failures

---

## File Structure

```
scor_risk_game_netlify_deploy.zip contains:
├── dist/
│   ├── public/           ← Frontend build (HTML, CSS, JS)
│   └── index.js          ← Backend server
├── netlify.toml          ← Netlify configuration
├── package.json          ← Project metadata
└── pnpm-lock.yaml        ← Dependency lock file
```

---

## Environment Variables (if needed)

If you need to add environment variables:

1. Go to **Site settings** → **Build & deploy** → **Environment**
2. Add your variables
3. Redeploy the site

---

## Support

- **Netlify Docs:** https://docs.netlify.com
- **GitHub Help:** https://docs.github.com
- **SCOR-RISK Game:** Check the game's help section

---

**Version:** 2.0 (Fixed - GitHub Recommended)
**Last Updated:** November 2025
**Status:** Production Ready ✅
