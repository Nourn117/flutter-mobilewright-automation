# Register

Covers account creation: success flow, duplicate email, field validation rules and dialog behaviour.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-REG-001 | Register a new account | Positive | P1 | On "Create account" screen | 1. Full name `Nouran Test`<br>2. Email `new.user@demo.com`<br>3. Password `Test@1234`<br>4. Confirm password `Test@1234`<br>5. Tap **Create account** | • Button shows loading spinner<br>• Dialog "Account created" appears with "You can now log in with new.user@demo.com." | Planned |
| TC-REG-002 | Success dialog returns to Login with email pre-filled | Positive | P1 | TC-REG-001 dialog visible | 1. Tap **Go to Login** | • Login screen is shown<br>• Email field contains `new.user@demo.com`<br>• Password field is empty | Planned |
| TC-REG-003 | Login with the newly registered account | Positive | P1 | TC-REG-002 done | 1. Enter password `Test@1234`<br>2. Tap **Log in** | • Home opens<br>• Greeting shows "Hello, Nouran 👋"<br>• Profile shows "Nouran Test" / `new.user@demo.com` | Planned |
| TC-REG-004 | Register with an already registered email | Negative | P1 | On "Create account" screen | 1. Fill valid name and passwords<br>2. Email `test@demo.com`<br>3. Tap **Create account** | • Error banner shows "Email already registered"<br>• No dialog is shown | Planned |
| TC-REG-005 | Submit with all fields empty | Negative | P1 | On "Create account" screen | 1. Tap **Create account** without filling anything | • "Name is required"<br>• "Email is required"<br>• "Password is required"<br>• "Please confirm your password"<br>• No request sent | Planned |
| TC-REG-006 | Name shorter than 3 characters | Negative | P2 | On "Create account" screen | 1. Full name `Ab`<br>2. Fill other fields with valid data<br>3. Tap **Create account** | "Name must be at least 3 characters" | Planned |
| TC-REG-007 | Name with spaces only | Negative | P3 | On "Create account" screen | 1. Full name `   `<br>2. Tap **Create account** | "Name is required" | Planned |
| TC-REG-008 | Name boundary – exactly 3 characters | Edge | P3 | On "Create account" screen | 1. Full name `Ali`<br>2. Fill other fields with valid unique data<br>3. Tap **Create account** | No name error; account is created | Planned |
| TC-REG-009 | Invalid email format | Negative | P2 | On "Create account" screen | 1. Email `user@demo`<br>2. Fill other fields with valid data<br>3. Tap **Create account** | "Enter a valid email" | Planned |
| TC-REG-010 | Password length boundary (7 vs 8 characters) | Edge | P2 | On "Create account" screen | 1. Password `Abcde12` (7 chars) and same confirm → tap **Create account**<br>2. Change to `Abcdef12` (8 chars) and same confirm → tap **Create account** | • 7 chars: "Password must be at least 8 characters"<br>• 8 chars: no password error | Planned |
| TC-REG-011 | Password without an uppercase letter | Negative | P2 | On "Create account" screen | 1. Password and confirm `test@1234`<br>2. Tap **Create account** | "Password must contain an uppercase letter" | Planned |
| TC-REG-012 | Password without a number | Negative | P2 | On "Create account" screen | 1. Password and confirm `Test@abcd`<br>2. Tap **Create account** | "Password must contain a number" | Planned |
| TC-REG-013 | Password without a special character is accepted | Edge | P3 | On "Create account" screen | 1. Password and confirm `Test1234`<br>2. Fill other fields with valid unique data<br>3. Tap **Create account** | Account is created (special character is not required) | Planned |
| TC-REG-014 | Confirm password does not match | Negative | P1 | On "Create account" screen | 1. Password `Test@1234`<br>2. Confirm `Test@12345`<br>3. Tap **Create account** | "Passwords do not match" | Planned |
| TC-REG-015 | Password fields are masked | UI | P3 | On "Create account" screen | 1. Type into Password and Confirm password | Characters are masked in both fields | Planned |
| TC-REG-016 | Success dialog cannot be dismissed by tapping outside | Edge | P3 | Success dialog visible | 1. Tap outside the dialog | Dialog stays open until **Go to Login** is tapped | Planned |
| TC-REG-017 | Back from Register without submitting | Positive | P3 | On "Create account" screen | 1. Type an email<br>2. Tap the AppBar back arrow | Login screen is shown and the email field is **not** pre-filled | Planned |
| TC-REG-018 | Name and email are trimmed | Edge | P3 | On "Create account" screen | 1. Full name `  Sara Ali  `<br>2. Email `  sara@demo.com  `<br>3. Valid passwords<br>4. Tap **Create account** | Dialog shows "You can now log in with sara@demo.com."; login with `sara@demo.com` works | Planned |
| TC-REG-019 | Registered account is not kept after app restart | Edge | P3 | Account `new.user@demo.com` registered | 1. Kill and relaunch the app<br>2. Login with `new.user@demo.com` / `Test@1234` | "Invalid email or password" (mock data is in-memory, see OBS-04) | Manual |

[← Back to test plan](README.md)
