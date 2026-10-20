# Product Details

Covers the details screen, quantity selection and the add-to-cart confirmation sheet.

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-DET-001 | Details show correct product data | Positive | P1 | Opened details of Smart Watch | 1. Observe the screen | • Title "Details"<br>• Category chip "Wearables"<br>• Name "Smart Watch"<br>• Price "EGP 5,999"<br>• Section "About this product" with description | Planned |
| TC-DET-002 | Default quantity is 1 and minus is disabled | UI | P2 | On any product details | 1. Observe the quantity stepper | • Quantity shows **1**<br>• **−** button is disabled | Planned |
| TC-DET-003 | Increase quantity updates button total | Positive | P1 | On Wireless Headphones details | 1. Tap **+** twice | • Quantity shows **3**<br>• Button shows "Add to cart · EGP 7,497" | Planned |
| TC-DET-004 | Decrease quantity | Positive | P2 | Quantity is 3 | 1. Tap **−** once | Quantity shows **2** and button total updates | Planned |
| TC-DET-005 | Maximum quantity is 10 | Edge | P2 | On any product details | 1. Tap **+** until it is disabled | • Quantity stops at **10**<br>• **+** button is disabled | Planned |
| TC-DET-006 | Add to cart shows confirmation sheet | Positive | P1 | Logged in, cart is empty, on Wireless Headphones details | 1. Tap **Add to cart** | • Bottom sheet "Added to cart" with "1 × Wireless Headphones"<br>• Buttons **Keep shopping** and **Go to cart**<br>• Cart badge shows 1 | Planned |
| TC-DET-007 | Keep shopping returns to Shop | Positive | P1 | Added-to-cart sheet visible | 1. Tap **Keep shopping** | • Sheet closes and Shop grid is shown<br>• Item remains in cart | Planned |
| TC-DET-008 | Go to cart opens the Cart tab | Positive | P1 | Added-to-cart sheet visible | 1. Tap **Go to cart** | • Cart tab is selected<br>• Added product is listed with the right quantity | Planned |
| TC-DET-009 | Dismiss the sheet without choosing | Edge | P3 | Added-to-cart sheet visible with quantity 3 | 1. Swipe the sheet down (or tap outside) | • User stays on Details<br>• Quantity resets to **1**<br>• Item (qty 3) is still in the cart | Planned |
| TC-DET-010 | Add with quantity > 1 | Positive | P2 | Logged in, cart is empty | 1. Open Bluetooth Speaker<br>2. Set quantity to 3<br>3. Tap **Add to cart** | • Sheet shows "3 × Bluetooth Speaker"<br>• Badge shows 3 | Planned |
| TC-DET-011 | Adding the same product twice merges quantity | Positive | P1 | Logged in, cart is empty | 1. Add 1 × Laptop Stand → **Keep shopping**<br>2. Add 2 × Laptop Stand → **Go to cart** | Cart has **one** Laptop Stand row with quantity **3** | Planned |
| TC-DET-012 | Adding different products creates separate rows | Positive | P2 | Logged in, cart is empty | 1. Add USB-C Hub<br>2. Add Fitness Band<br>3. Open Cart | Two rows: USB-C Hub and Fitness Band | Planned |
| TC-DET-013 | Cart quantity limit when adding the same product repeatedly | Negative | P2 | Logged in, cart is empty | 1. Add 10 × Smart Watch → **Keep shopping**<br>2. Add 5 × Smart Watch → **Go to cart** | Quantity should be capped at **10** — ❌ currently becomes 15 (**BUG-01**) | Planned |
| TC-DET-014 | Back from details keeps search | Edge | P3 | Searched `wireless`, opened Wireless Earbuds | 1. Tap AppBar back | Shop shows the filtered results for `wireless` | Planned |

[← Back to test plan](README.md)
