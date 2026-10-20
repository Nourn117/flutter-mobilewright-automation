# Profile

Covers user details, dark mode and logout.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-PROF-001 | Profile shows user data | Positive | P1 | Logged in as `test@demo.com` | 1. Open Profile | • Avatar letter "T"<br>• Name "Test User"<br>• Email `test@demo.com` | Planned |
| TC-PROF-002 | Turn dark mode on | Positive | P2 | On Profile, light mode | 1. Turn on **Dark mode**<br>2. Visit Shop and Cart | Whole app switches to dark theme | Planned |
| TC-PROF-003 | Turn dark mode off | Positive | P3 | Dark mode on | 1. Turn off **Dark mode** | App returns to light theme | Planned |
| TC-PROF-004 | Logout confirmation dialog | UI | P2 | On Profile | 1. Tap **Log out** | • Dialog "Log out?" with "Your cart will be cleared."<br>• Buttons **Cancel** and **Log out** | Planned |
| TC-PROF-005 | Cancel logout | Positive | P2 | Logout dialog visible, cart has items | 1. Tap **Cancel** | • Dialog closes, user stays on Profile<br>• Cart items are kept | Planned |
| TC-PROF-006 | Confirm logout | Positive | P1 | Logged in, cart has items, dark mode on | 1. Tap **Log out** → **Log out** | • Login screen is shown<br>• Cart is cleared<br>• Theme resets to light | Planned |
| TC-PROF-007 | Back after logout does not return to Home | Edge | P2 | Just logged out | 1. Press the Android back button | App goes to background; Home is not shown | Planned |

[← Back to test plan](README.md)
