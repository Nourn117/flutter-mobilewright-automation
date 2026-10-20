# Home & Navigation

Covers the bottom navigation bar, tab switching and the cart badge.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-NAV-001 | Bottom navigation default state | UI | P1 | Just logged in | 1. Observe the bottom navigation | • Tabs: **Shop**, **Cart**, **Profile**<br>• **Shop** is selected | Planned |
| TC-NAV-002 | Switch between tabs | Positive | P1 | Logged in as `test@demo.com` | 1. Tap **Cart**<br>2. Tap **Profile**<br>3. Tap **Shop** | • Cart shows title "My Cart"<br>• Profile shows title "Profile"<br>• Shop shows the product grid | Planned |
| TC-NAV-003 | Cart badge hidden when cart is empty | UI | P2 | Logged in, cart is empty | 1. Observe the Cart tab icon | No badge is displayed | Planned |
| TC-NAV-004 | Cart badge shows total quantity | Positive | P1 | Logged in, cart is empty | 1. Add 2 × Wireless Headphones<br>2. Add 1 × Bluetooth Speaker | Badge shows **3** (sum of quantities, not number of products) | Planned |
| TC-NAV-005 | Badge updates after cart changes | Positive | P2 | Cart has 2 × Wireless Headphones | 1. Open Cart<br>2. Tap **+** once<br>3. Remove the item | • Badge shows 3 after increasing<br>• Badge disappears after removing | Planned |
| TC-NAV-006 | Tab state is preserved | Edge | P3 | Logged in as `test@demo.com` | 1. On Shop, search `watch`<br>2. Switch to Profile<br>3. Switch back to Shop | Search text `watch` and filtered results are still shown | Planned |
| TC-NAV-007 | Shop tab selected after re-login | Edge | P3 | Logged in, Profile tab selected | 1. Log out<br>2. Log in again | Home opens on the **Shop** tab | Planned |

[← Back to test plan](README.md)
