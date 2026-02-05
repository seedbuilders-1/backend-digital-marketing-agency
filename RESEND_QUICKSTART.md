# Resend Email Service - Quick Reference

## 🚀 Quick Start

### 1. Get API Key

- Sign up: https://resend.com/signup
- Get API key: https://resend.com/api-keys
- Copy the key (starts with `re_`)

### 2. Update `.env.local`

```env
RESEND_API_KEY=re_your_actual_api_key_here
EMAIL_FROM="Digital Marketing Agency <onboarding@resend.dev>"
```

### 3. Restart Server

```bash
# Docker
docker-compose restart

# Or direct
npm start
```

## 📧 Email Configuration

### Development (Testing)

```env
EMAIL_FROM="Digital Marketing Agency <onboarding@resend.dev>"
```

✅ Works immediately, no domain verification needed

### Production

1. Add domain at https://resend.com/domains
2. Verify DNS records
3. Update `.env`:

```env
EMAIL_FROM="Digital Marketing Agency <noreply@yourdomain.com>"
```

## 🔍 Monitoring

**Dashboard**: https://resend.com/emails

- View all sent emails
- Check delivery status
- Debug issues
- See open/click rates

## ✅ What's Different

| Before (Zoho/Nodemailer) | After (Resend)    |
| ------------------------ | ----------------- |
| SMTP host/port/auth      | Simple API key    |
| Connection timeouts      | Instant API calls |
| Manual retry logic       | Built-in retries  |
| No analytics             | Full dashboard    |
| Complex setup            | 2-minute setup    |

## 🎯 Usage (No Code Changes!)

The `sendEmail()` function works exactly the same:

```javascript
const { sendEmail } = require("../utils/emailService");

// Same API as before
await sendEmail(
  "user@example.com",
  "Subject",
  "Plain text",
  "<h1>HTML content</h1>",
);
```

## 📊 Free Tier Limits

- **3,000 emails/month** - Free
- **50,000 emails/month** - $20/month

## 🆘 Troubleshooting

| Issue              | Solution                                |
| ------------------ | --------------------------------------- |
| "Invalid API key"  | Check `RESEND_API_KEY` in `.env`        |
| "Invalid sender"   | Use `onboarding@resend.dev` for testing |
| Email not received | Check Resend dashboard + spam folder    |
| Server error       | Restart server after `.env` changes     |

## 📚 Resources

- Docs: https://resend.com/docs
- API Reference: https://resend.com/docs/api-reference
- Support: https://resend.com/support

---

**That's it! Your email service is now powered by Resend. 🎉**
