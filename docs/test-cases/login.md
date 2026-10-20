# Login

Covers authentication on the Login screen: valid login, invalid credentials, locked account, field validation and UI behaviour.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-LOGIN-001 | Login with valid credentials | Positive | P1 | App launched on Login screen | 1. Enter email `test@demo.com`<br>2. Enter password `Test@1234`<br>3. Tap **Log in** | • Login button shows a loading spinner<br>• Home opens on the **Shop** tab<br>• Greeting shows "Hello, Test 👋" | Planned |
| TC-LOGIN-002 | Login button is disabled while request is in progress | UI | P2 | App on Login screen | 1. Enter valid credentials<br>2. Tap **Log in**<br>3. Immediately tap **Log in** again | • Spinner is shown inside the button<br>• Button and "Register" link are disabled during loading<br>• Only one login request is processed | Planned |
| TC-LOGIN-003 | Login with wrong password | Negative | P1 | App on Login screen | 1. Enter email `test@demo.com`<br>2. Enter password `Wrong@123`<br>3. Tap **Log in** | • Error banner shows "Invalid email or password"<br>• User stays on Login screen<br>• Entered email and password are kept | Planned |
| TC-LOGIN-004 | Login with unregistered email | Negative | P1 | App on Login screen | 1. Enter email `nobody@demo.com`<br>2. Enter password `Test@1234`<br>3. Tap **Log in** | Error banner shows "Invalid email or password" | Planned |
| TC-LOGIN-005 | Login with locked account | Negative | P1 | App on Login screen | 1. Enter email `locked@demo.com`<br>2. Enter password `Test@1234`<br>3. Tap **Log in** | • Error banner shows "This account is locked"<br>• User is not navigated to Home | Planned |
| TC-LOGIN-006 | Submit with all fields empty | Negative | P1 | App on Login screen | 1. Leave email and password empty<br>2. Tap **Log in** | • "Email is required" under email<br>• "Password is required" under password<br>• No loading spinner (no request sent) | Planned |
| TC-LOGIN-007 | Submit with empty email only | Negative | P2 | App on Login screen | 1. Leave email empty<br>2. Enter password `Test@1234`<br>3. Tap **Log in** | "Email is required" is shown; no request sent | Planned |
| TC-LOGIN-008 | Submit with empty password only | Negative | P2 | App on Login screen | 1. Enter email `test@demo.com`<br>2. Leave password empty<br>3. Tap **Log in** | "Password is required" is shown; no request sent | Planned |
| TC-LOGIN-009 | Invalid email formats (data-driven) | Negative | P2 | App on Login screen | 1. Enter each email: `test@demo`, `testdemo.com`, `test @demo.com`, `@demo.com`<br>2. Enter password `Test@1234`<br>3. Tap **Log in** | "Enter a valid email" is shown for every value; no request sent | Planned |
| TC-LOGIN-010 | Email with leading/trailing spaces is trimmed | Edge | P3 | App on Login screen | 1. Enter email `  test@demo.com  `<br>2. Enter password `Test@1234`<br>3. Tap **Log in** | Login succeeds and Home opens | Planned |
| TC-LOGIN-011 | Email is case-sensitive | Edge | P3 | App on Login screen | 1. Enter email `TEST@demo.com`<br>2. Enter password `Test@1234`<br>3. Tap **Log in** | Error banner shows "Invalid email or password" (see OBS-01) | Planned |
| TC-LOGIN-012 | Password is case-sensitive | Negative | P2 | App on Login screen | 1. Enter email `test@demo.com`<br>2. Enter password `test@1234`<br>3. Tap **Log in** | Error banner shows "Invalid email or password" | Planned |
| TC-LOGIN-013 | Show / hide password toggle | UI | P2 | App on Login screen | 1. Enter password `Test@1234`<br>2. Tap the eye icon<br>3. Tap the eye icon again | • Password is masked by default<br>• After first tap the password is visible (tooltip "Hide password")<br>• After second tap it is masked again (tooltip "Show password") | Planned |
| TC-LOGIN-014 | Submit from keyboard action | Positive | P3 | App on Login screen | 1. Enter valid email and password<br>2. Press the keyboard **Done/Enter** key while in the password field | Login is submitted and Home opens | Planned |
| TC-LOGIN-015 | Recover after a failed attempt | Positive | P2 | TC-LOGIN-003 executed (error banner visible) | 1. Correct the password to `Test@1234`<br>2. Tap **Log in** | Error banner disappears and Home opens | Planned |
| TC-LOGIN-016 | Navigate to Register | Positive | P2 | App on Login screen | 1. Tap **Register** ("Don't have an account?") | "Create account" screen opens | Planned |
| TC-LOGIN-017 | Back button after login does not return to Login | Edge | P2 | Logged in, on Home | 1. Press the Android back button | App goes to background/closes; Login screen is not shown | Planned |
| TC-LOGIN-018 | Login screen UI elements | UI | P3 | App on Login screen | 1. Observe the screen | • Bag icon, title "Welcome back", subtitle "Log in to continue shopping"<br>• Email and Password fields with icons<br>• **Log in** button and "Don't have an account? Register" link | Planned |

[← Back to test plan](README.md)
