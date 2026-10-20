# Order Success

Covers the confirmation screen shown after placing an order.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-ORD-001 | Order success details | Positive | P1 | Order placed via TC-CHK-002 (first order of the session) | 1. Observe the screen | • Title "Order placed!"<br>• "Thanks Test, we will deliver to Cairo on <date>."<br>• Order number **ORD-1001**<br>• Time slot, Payment, Items = 1, Delivery EGP 50, Total paid EGP 6,049 | Planned |
| TC-ORD-002 | Ordered items list | Positive | P2 | Order with 2 × Wireless Headphones and 1 × Bluetooth Speaker | 1. Scroll to the items list | • Wireless Headphones – Qty 2 – EGP 4,998<br>• Bluetooth Speaker – Qty 1 – EGP 1,299<br>• Items = 3, Total paid = EGP 6,347 | Planned |
| TC-ORD-003 | Order numbers are sequential | Positive | P2 | One order already placed in this session | 1. Place a second order | Order number is **ORD-1002** | Planned |
| TC-ORD-004 | Back to shopping | Positive | P1 | On Order success | 1. Tap **Back to shopping** | • Shop tab is shown<br>• Cart badge is hidden | Planned |
| TC-ORD-005 | Android back behaves like Back to shopping | Edge | P2 | On Order success | 1. Press the Android back button | Shop tab is shown (Checkout is **not** shown again) | Planned |
| TC-ORD-006 | Cart is empty after placing an order | Positive | P1 | Order placed | 1. Open the Cart tab | Empty cart state | Planned |

[← Back to test plan](README.md)
