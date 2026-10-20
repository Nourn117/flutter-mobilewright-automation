# End-to-End Journeys

Full user journeys that cross several screens. These are the main candidates for the smoke suite.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-E2E-001 | New customer journey | Positive | P1 | App launched | 1. Register `e2e.user@demo.com` / `Test@1234`<br>2. Log in<br>3. Search `watch`, open Smart Watch<br>4. Set quantity 2 → **Add to cart** → **Go to cart**<br>5. **Proceed to checkout**, fill valid data, **Place order**<br>6. **Back to shopping**<br>7. Log out | • Every step succeeds<br>• Order success shows ORD-1001, Items 2, Total EGP 12,048<br>• Login screen at the end | Planned |
| TC-E2E-002 | Returning customer edits cart before ordering | Positive | P1 | App launched | 1. Log in as `test@demo.com`<br>2. Add 1 × Wireless Headphones, 2 × USB-C Hub, 1 × Fitness Band<br>3. In Cart: increase Headphones to 2, remove Fitness Band<br>4. Checkout with evening slot and card payment | • Cart total before checkout = EGP 6,546<br>• Order success shows Items 4, Total paid EGP 6,546, "5 PM - 9 PM", "Card on delivery" | Planned |
| TC-E2E-003 | Two orders in one session | Positive | P2 | Logged in | 1. Place an order<br>2. Back to shopping<br>3. Place another order | Order numbers are ORD-1001 then ORD-1002; cart is empty after each | Planned |
| TC-E2E-004 | Locked user cannot reach the shop | Negative | P1 | App launched | 1. Log in as `locked@demo.com` / `Test@1234` | "This account is locked"; Home is never shown | Planned |
| TC-E2E-005 | Cart is isolated between sessions | Positive | P2 | App launched | 1. Log in, add items<br>2. Log out<br>3. Log in again | Cart is empty and badge hidden | Planned |

[← Back to test plan](README.md)
