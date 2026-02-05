# Delete User Logging - Debugging Guide

## ✅ Comprehensive Logging Added

I've added detailed logging throughout the entire delete user flow to help you debug the 500 error.

---

## 🔍 What You'll See in the Logs

### **When Delete Request Starts:**

```
========================================
[CONTROLLER] DELETE USER REQUEST RECEIVED
========================================
Request params: { id: 'user-uuid-here' }
Request user (from auth): { id: 'admin-id', email: 'admin@example.com', role: 'admin' }
Timestamp: 2026-02-05T21:47:19.000Z
[CONTROLLER] Attempting to delete user with ID: user-uuid-here
[SERVICE] deleteUser called with ID: user-uuid-here
=== DELETE USER STARTED ===
User ID to delete: user-uuid-here
Step 1: Fetching user data...
User found: { id: 'user-uuid-here', name: 'John Doe', email: 'john@example.com' }
Step 2: Starting transaction to delete all related records...
Transaction started
Step 2.1: Finding service requests...
Found 3 service requests
Processing service request: request-id-1
  - Deleting milestone deliverables...
  - Deleted 2 milestone deliverables
  - Deleting milestones...
  - Deleted 5 milestones
... (continues for each step)
Step 2.13: Deleting user record...
User record deleted successfully
Transaction completed successfully
Step 3: All deletions completed successfully
=== DELETE USER COMPLETED ===
[SERVICE] deleteUser completed successfully
[CONTROLLER] User deleted successfully: { id: '...', name: '...', email: '...' }
========================================
[CONTROLLER] DELETE USER SUCCESS
========================================
```

---

### **When Delete Fails (500 Error):**

```
========================================
[CONTROLLER] DELETE USER REQUEST RECEIVED
========================================
Request params: { id: 'user-uuid-here' }
...
=== DELETE USER STARTED ===
User ID to delete: user-uuid-here
Step 1: Fetching user data...
User found: { ... }
Step 2: Starting transaction to delete all related records...
Transaction started
Step 2.1: Finding service requests...
Found 2 service requests
Step 2.2: Deleting messages...
[ERROR OCCURS HERE - You'll see exactly which step failed]
=== DELETE USER FAILED ===
Error type: PrismaClientKnownRequestError
Error message: Foreign key constraint failed on the field: `some_field`
Error stack: [full stack trace]
Full error object: [complete error details]
[SERVICE] deleteUser failed: Foreign key constraint failed...
========================================
[CONTROLLER] DELETE USER ERROR
========================================
Error name: PrismaClientKnownRequestError
Error message: Foreign key constraint failed...
Error stack: [full stack trace]
Full error: [complete error object]
========================================
```

---

## 📋 Logging Breakdown

### **Controller Level** (`controllers/userControllers.js`)

- ✅ Request received timestamp
- ✅ Request parameters
- ✅ Authenticated user info
- ✅ Success confirmation
- ✅ Detailed error information

### **Service Level** (`services/userServices.js`)

- ✅ Service method entry
- ✅ Service method exit
- ✅ Service-level errors

### **Model Level** (`models/userModels.js`)

- ✅ Operation start/end markers
- ✅ User lookup confirmation
- ✅ Transaction start
- ✅ Each deletion step with counts
- ✅ Detailed error information

---

## 🎯 How to Use These Logs

### **Step 1: Trigger the Delete**

1. Go to `/admin/user-management`
2. Click delete on a user
3. Confirm deletion

### **Step 2: Check Your Server Logs**

Look for the section starting with:

```
========================================
[CONTROLLER] DELETE USER REQUEST RECEIVED
========================================
```

### **Step 3: Find Where It Fails**

The logs will show you **exactly** which step failed:

- Step 1: User lookup
- Step 2.1: Service requests
- Step 2.2: Messages
- Step 2.3: Conversations
- Step 2.4: Service requests deletion
- Step 2.5: Payments
- Step 2.6: Invoices
- Step 2.7: Referrals
- Step 2.8-2.11: Settings
- Step 2.12: Organizations
- Step 2.13: User record

### **Step 4: Analyze the Error**

Look for:

- **Error type**: `PrismaClientKnownRequestError`, `Error`, etc.
- **Error message**: Specific error description
- **Error stack**: Where in the code it failed

---

## 🔧 Common Errors and Solutions

### **Error: Foreign Key Constraint Failed**

```
Error message: Foreign key constraint failed on the field: `user_id`
```

**Cause:** There's a related record we're not deleting  
**Solution:** Add deletion for that table in the transaction

---

### **Error: User not found**

```
ERROR: User not found with ID: abc-123
```

**Cause:** User doesn't exist or already deleted  
**Solution:** Check if user ID is correct

---

### **Error: Transaction timeout**

```
Error: Transaction API timeout
```

**Cause:** Too much data to delete, transaction taking too long  
**Solution:** Increase transaction timeout or delete in batches

---

### **Error: Table does not exist**

```
Error: Table 'dma_dev_db.some_table' doesn't exist
```

**Cause:** Database schema mismatch  
**Solution:** Run migrations: `npx prisma migrate dev`

---

## 📊 Example Log Output

Here's what a successful deletion looks like:

```
========================================
[CONTROLLER] DELETE USER REQUEST RECEIVED
========================================
Request params: { id: 'cm5abc123xyz' }
Request user (from auth): { id: 'admin-id', email: 'admin@test.com', role: 'admin' }
Timestamp: 2026-02-05T21:47:19.123Z
[CONTROLLER] Attempting to delete user with ID: cm5abc123xyz
[SERVICE] deleteUser called with ID: cm5abc123xyz
=== DELETE USER STARTED ===
User ID to delete: cm5abc123xyz
Step 1: Fetching user data...
User found: { id: 'cm5abc123xyz', name: 'Test User', email: 'test@example.com' }
Step 2: Starting transaction to delete all related records...
Transaction started
Step 2.1: Finding service requests...
Found 0 service requests
Step 2.2: Deleting messages...
Deleted 0 messages
Step 2.3: Deleting conversations...
Deleted 0 conversations
Step 2.4: Deleting service requests...
Deleted 0 service requests
Step 2.5: Deleting payments...
Deleted 0 payments
Step 2.6: Deleting invoices...
Deleted 0 invoices
Step 2.7: Deleting referrals...
Deleted 0 referrals
Step 2.8: Deleting OTPs...
Deleted 1 OTPs
Step 2.9: Deleting password tokens...
Deleted 0 password tokens
Step 2.10: Deleting privacy settings...
Deleted 1 privacy settings
Step 2.11: Deleting notification settings...
Deleted 1 notification settings
Step 2.12: Deleting organizations...
Deleted 0 organizations
Step 2.13: Deleting user record...
User record deleted successfully
Transaction completed successfully
Step 3: All deletions completed successfully
=== DELETE USER COMPLETED ===
[SERVICE] deleteUser completed successfully
[CONTROLLER] User deleted successfully: { id: 'cm5abc123xyz', name: 'Test User', email: 'test@example.com' }
========================================
[CONTROLLER] DELETE USER SUCCESS
========================================
```

---

## 🚀 Next Steps

1. **Try deleting a user again**
2. **Copy the entire log output** from your server console
3. **Share the logs** - I can help identify the exact issue
4. **Look for the step that fails** - It will be obvious in the logs

---

## 📝 Files Modified

- ✅ `controllers/userControllers.js` - Added controller-level logging
- ✅ `services/userServices.js` - Added service-level logging
- ✅ `models/userModels.js` - Added detailed step-by-step logging

---

**The logs will now show you EXACTLY where the delete operation is failing!** 🎯
