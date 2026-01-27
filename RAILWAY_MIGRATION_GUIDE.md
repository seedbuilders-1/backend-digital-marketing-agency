# 🚂 Railway Migration Guide - Digital Marketing Agency

## Overview

This guide will help you migrate your Node.js backend and MySQL database from cPanel to Railway.

---

## 📋 Prerequisites

- [ ] Railway account (sign up at https://railway.app)
- [ ] GitHub account (to deploy from repository)
- [ ] Database backup file

---

## Phase 1: Database Migration

### Step 1: Export Current Database

From your cPanel SSH terminal:

```bash
# Navigate to home directory
cd ~

# Export database
mysqldump -u secukgjn_seedbuilders -p secukgjn_dma_prod > dma_backup_$(date +%Y%m%d).sql

# Verify the export
ls -lh dma_backup_*.sql
```

Password: `SeedBuilderswejejje3`

### Step 2: Download Database Backup

1. Go to **cPanel File Manager**
2. Navigate to `/home/secukgjn/`
3. Find `dma_backup_YYYYMMDD.sql`
4. Right-click → **Download**

---

## Phase 2: Setup Railway Database

### Option A: Railway MySQL (Recommended)

1. Go to https://railway.app/new
2. Click **"+ New Project"**
3. Click **"+ New"** → **"Database"** → **"MySQL"**
4. Wait for provisioning (~30 seconds)
5. Click on the MySQL service
6. Go to **"Variables"** tab
7. Copy these values:
   - `MYSQL_URL` (full connection string)
   - `MYSQL_HOST`
   - `MYSQL_PORT`
   - `MYSQL_USER`
   - `MYSQL_PASSWORD`
   - `MYSQL_DATABASE`

### Step 3: Import Database to Railway

**Method 1: Using MySQL Workbench (GUI)**

1. Download MySQL Workbench
2. Create new connection using Railway credentials
3. File → Run SQL Script → Select your backup file
4. Execute

**Method 2: Using Command Line**

```bash
# Install mysql client if needed
# Windows: Download from mysql.com
# Mac: brew install mysql-client

# Import to Railway
mysql -h <RAILWAY_HOST> -P <RAILWAY_PORT> -u <RAILWAY_USER> -p<RAILWAY_PASSWORD> <RAILWAY_DATABASE> < dma_backup_YYYYMMDD.sql
```

Replace the placeholders with values from Railway Variables tab.

---

## Phase 3: Deploy Backend to Railway

### Step 1: Push Code to GitHub

If your backend isn't on GitHub yet:

```bash
cd c:\Users\USMAN\Documents\dma-backend

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit for Railway deployment"

# Create a new repository on GitHub (https://github.com/new)
# Then link it:
git remote add origin https://github.com/YOUR_USERNAME/dma-backend.git
git branch -M main
git push -u origin main
```

### Step 2: Deploy to Railway

1. Go to https://railway.app/new
2. Click **"Deploy from GitHub repo"**
3. Select your `dma-backend` repository
4. Railway will auto-detect it's a Node.js app
5. Click **"Deploy"**

### Step 3: Configure Environment Variables

1. Click on your deployed service
2. Go to **"Variables"** tab
3. Click **"+ New Variable"**
4. Add these variables:

```env
DATABASE_URL=<Copy from Railway MySQL Variables tab>
JWT_ACCESS_SECRET=ssn
JWT_REFRESH_SECRET=dbdbbdd
PORT=3000
NODE_ENV=production

# Cloudinary (from your current .env)
CLOUDINARY_CLOUD_NAME=<your_value>
CLOUDINARY_API_KEY=<your_value>
CLOUDINARY_API_SECRET=<your_value>

# Email (from your current .env)
EMAIL_USER=<your_value>
EMAIL_PASS=<your_value>

# Paystack (from your current .env)
PAYSTACK_SECRET_KEY=<your_value>
```

### Step 4: Run Database Migrations

1. In Railway, click on your backend service
2. Go to **"Settings"** tab
3. Scroll to **"Deploy"** section
4. Add a **"Build Command"**:

   ```bash
   npm install && npx prisma generate && npx prisma migrate deploy
   ```

5. Click **"Redeploy"**

---

## Phase 4: Update Frontend

### Step 1: Get Railway Backend URL

1. In Railway, click on your backend service
2. Go to **"Settings"** tab
3. Scroll to **"Networking"**
4. Click **"Generate Domain"**
5. Copy the URL (e.g., `https://dma-backend-production.up.railway.app`)

### Step 2: Update Frontend Environment Variables

Update your frontend `.env.local`:

```env
NEXT_PUBLIC_API_BASE_URL=https://dma-backend-production.up.railway.app
```

### Step 3: Deploy Frontend

If your frontend is on Vercel:

1. Go to Vercel dashboard
2. Select your project
3. Go to **"Settings"** → **"Environment Variables"**
4. Update `NEXT_PUBLIC_API_BASE_URL`
5. Go to **"Deployments"**
6. Click **"Redeploy"** on the latest deployment

---

## Phase 5: Testing

### Test Backend API

```bash
# Test health endpoint
curl https://YOUR-RAILWAY-URL.up.railway.app/api/services/public

# Should return JSON with services
```

### Test Frontend

1. Visit your frontend URL
2. Try logging in
3. Try accessing services
4. Check browser console for errors

---

## Phase 6: Custom Domain (Optional)

### Add Custom Domain to Railway

1. In Railway, click on your backend service
2. Go to **"Settings"** → **"Networking"**
3. Click **"Custom Domain"**
4. Enter: `api.digitalmarketingagency.ng`
5. Railway will show DNS records to add

### Update DNS

1. Go to your domain registrar
2. Add the CNAME record provided by Railway
3. Wait for DNS propagation (5-30 minutes)

---

## 🎉 Migration Complete!

Your stack is now:

- ✅ **Backend**: Railway (Node.js + MySQL)
- ✅ **Frontend**: Vercel (Next.js)
- ✅ **Database**: Railway MySQL
- ✅ **Custom Domain**: api.digitalmarketingagency.ng

---

## 💰 Cost Comparison

**cPanel (Current)**

- ~$10-30/month

**Railway (New)**

- Free tier: $5 credit/month
- Hobby plan: $5/month (if you exceed free tier)
- MySQL: Included in free tier

**Total**: $0-5/month (much cheaper!)

---

## 🆘 Troubleshooting

### Database Connection Issues

If you get "Can't connect to database":

1. Check `DATABASE_URL` format:

   ```
   mysql://user:password@host:port/database
   ```

2. Run Prisma generate:
   ```bash
   npx prisma generate
   ```

### Build Failures

If Railway build fails:

1. Check build logs in Railway dashboard
2. Make sure `package.json` has correct scripts
3. Verify all dependencies are in `package.json`

### CORS Issues

If frontend can't connect:

1. Update CORS in `server.js`:

   ```javascript
   cors({
     origin: [
       "https://digitalmarketingagency.ng",
       "https://www.digitalmarketingagency.ng",
     ],
     // ... rest of config
   });
   ```

2. Redeploy backend

---

## 📞 Need Help?

- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- Prisma Docs: https://www.prisma.io/docs

---

**Good luck with your migration! 🚀**
