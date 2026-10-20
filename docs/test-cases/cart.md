# Cart

Covers cart items, quantity changes, removal, order summary and checkout entry.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-CART-001 | Empty cart state | UI | P1 | Logged in, cart is empty | 1. Open the Cart tab | • "Your cart is empty"<br>• "Browse our products and add something you like."<br>• **Start shopping** button | Planned |
| TC-CART-002 | Start shopping goes to Shop | Positive | P2 | Cart is empty, on Cart tab | 1. Tap **Start shopping** | Shop tab is selected | Planned |
| TC-CART-003 | Cart item shows correct data | Positive | P1 | Cart has 2 × Wireless Headphones | 1. Open Cart | • Name "Wireless Headphones"<br>• Unit price "EGP 2,499"<br>• Quantity **2**<br>• Line total "EGP 4,998" | Planned |
| TC-CART-004 | Increase quantity in cart | Positive | P1 | Cart has 1 × Bluetooth Speaker | 1. Tap **+** | • Quantity 2, line total "EGP 2,598"<br>• Subtotal, Total and badge update | Planned |
| TC-CART-005 | Decrease quantity in cart | Positive | P2 | Cart has 3 × Bluetooth Speaker | 1. Tap **−** | Quantity 2 and totals update | Planned |
| TC-CART-006 | Minus disabled at quantity 1 | Edge | P2 | Cart has 1 × any product | 1. Observe **−** | **−** is disabled (item is removed only by the delete icon) | Planned |
| TC-CART-007 | Plus disabled at quantity 10 | Edge | P2 | Cart has 9 × any product | 1. Tap **+** | • Quantity 10<br>• **+** is disabled | Planned |
| TC-CART-008 | Remove one item | Positive | P1 | Cart has Wireless Headphones and Bluetooth Speaker | 1. Tap the delete icon on Wireless Headphones | • Item is removed immediately (no confirmation)<br>• Totals are recalculated | Planned |
| TC-CART-009 | Remove the last item | Positive | P2 | Cart has one item | 1. Tap the delete icon | • Empty cart state is shown<br>• Badge disappears | Planned |
| TC-CART-010 | Order summary calculation | Positive | P1 | Cart: 2 × Wireless Headphones, 1 × Bluetooth Speaker | 1. Observe the summary | • Subtotal (3 items) = EGP 6,297<br>• Delivery = EGP 50<br>• Total = EGP 6,347 | Planned |
| TC-CART-011 | Subtotal label with a single item | UI | P3 | Cart has 1 × any product | 1. Observe the subtotal label | Should read "Subtotal (1 item)" — ❌ currently "Subtotal (1 items)" (**BUG-02**) | Planned |
| TC-CART-012 | Proceed to checkout | Positive | P1 | Cart has items | 1. Tap **Proceed to checkout** | Checkout screen opens | Planned |
| TC-CART-013 | Cart persists across tabs | Positive | P2 | Cart has items | 1. Switch to Profile<br>2. Switch back to Cart | Same items and quantities are shown | Planned |
| TC-CART-014 | Cart is cleared after logout | Positive | P2 | Cart has items | 1. Log out<br>2. Log in again<br>3. Open Cart | Empty cart state | Planned |
| TC-CART-015 | Cart is cleared after app restart | Edge | P3 | Cart has items | 1. Kill and relaunch the app<br>2. Log in<br>3. Open Cart | Empty cart state (in-memory cart, see OBS-04) | Manual |
| TC-CART-016 | Long cart list scrolls, summary stays visible | UI | P3 | All 8 products added | 1. Scroll the list | • All 8 rows can be reached<br>• Summary and **Proceed to checkout** stay visible at the bottom | Planned |

[← Back to test plan](README.md)
