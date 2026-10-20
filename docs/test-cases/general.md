# General & Non-functional

Cross-cutting checks: launch, rotation, theme, keyboard and accessibility.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-GEN-001 | App launch shows Login | Positive | P1 | App not running | 1. Launch the app | Login screen is shown (session is not persisted) | Planned |
| TC-GEN-002 | Rotate the device on main screens | Edge | P3 | Logged in as `test@demo.com` | 1. Rotate to landscape on Shop, Details, Cart, Checkout<br>2. Rotate back | No crash; content stays usable and data is kept | Planned |
| TC-GEN-003 | Dark mode readability | UI | P3 | Dark mode on | 1. Visit every screen | All texts, icons and errors are readable with enough contrast | Manual |
| TC-GEN-004 | Keyboard does not hide the focused field | UI | P3 | On Register or Checkout | 1. Tap the last text field | Screen scrolls so the field stays visible above the keyboard | Planned |
| TC-GEN-005 | Large font size | UI | P3 | Android font size set to Largest | 1. Visit every screen | No overflow (yellow/black stripes) or cut texts | Manual |
| TC-GEN-006 | App relaunch resets all mock data | Edge | P3 | Registered a user, placed an order | 1. Kill and relaunch the app<br>2. Log in as `test@demo.com` and place an order | Order number starts again from ORD-1001 | Manual |

[← Back to test plan](README.md)
