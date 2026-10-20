# Checkout

Covers the checkout form (contact, delivery, payment, extras), validation, order summary and placing an order.

## Test Data

| Field | Valid | Invalid |
|---|---|---|
| Full name | `Test User`, `Ali` | empty, `Ab` |
| Mobile number | `01012345678`, `01112345678`, `01212345678`, `01512345678` | empty, `01312345678`, `0101234567`, `010-1234567` |
| City | Cairo, Giza, Alexandria, Mansoura, Tanta, Aswan | not selected |
| Street address | `12 Tahrir Street, Downtown`, `12 Nile St` (10 chars) | empty, `Cairo` |
| Delivery date | tomorrow … tomorrow + 13 days | not selected, today, past |

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-CHK-001 | Checkout default state | UI | P1 | Logged in as `test@demo.com`, cart has items, on Checkout | 1. Observe all sections | • Full name pre-filled "Test User"<br>• Phone, address, notes empty; city not selected; date "Select a date"<br>• Time slot "9 AM - 1 PM" selected; payment "Cash on delivery" selected<br>• "Save this address" unchecked<br>• Order summary matches the cart | Planned |
| TC-CHK-002 | Place order with valid data (happy path) | Positive | P1 | Cart: 1 × Smart Watch, on Checkout | 1. Mobile `01012345678`<br>2. City **Cairo**<br>3. Address `12 Tahrir Street, Downtown`<br>4. Delivery date = tomorrow<br>5. Tap **Place order · EGP 6,049** | • Button shows spinner and is disabled<br>• Order success screen opens<br>• Cart becomes empty and badge disappears | Planned |
| TC-CHK-003 | Place order with evening slot and card payment | Positive | P1 | Cart has items, on Checkout | 1. Fill all required fields with valid data<br>2. Select **5 PM - 9 PM**<br>3. Select **Card on delivery**<br>4. Notes `Call before arriving`<br>5. Check **Save this address**<br>6. Tap **Place order** | • Order success screen opens<br>• Time slot "5 PM - 9 PM" and Payment "Card on delivery" are shown | Planned |
| TC-CHK-004 | Submit with all required fields empty | Negative | P1 | On Checkout, clear the Full name | 1. Tap **Place order** | • "Name is required"<br>• "Phone is required"<br>• "Please select a city"<br>• "Address is required"<br>• "Please select a delivery date"<br>• No order is placed | Planned |
| TC-CHK-005 | Name shorter than 3 characters | Negative | P2 | On Checkout | 1. Full name `Ab`<br>2. Fill the rest validly<br>3. Tap **Place order** | "Name must be at least 3 characters" | Planned |
| TC-CHK-006 | Invalid mobile numbers (data-driven) | Negative | P1 | On Checkout | 1. Enter each invalid number from the test data<br>2. Tap **Place order** | "Enter a valid Egyptian mobile number" for each value | Planned |
| TC-CHK-007 | Valid mobile prefixes (data-driven) | Positive | P2 | On Checkout | 1. Enter each valid number: 010…, 011…, 012…, 015…<br>2. Fill the rest validly<br>3. Tap **Place order** | No phone error; order is placed | Planned |
| TC-CHK-008 | Mobile number limited to 11 digits | Edge | P3 | On Checkout | 1. Type `010123456789` (12 digits) | Field contains only the first 11 digits | Planned |
| TC-CHK-009 | City dropdown options | UI | P2 | On Checkout | 1. Tap **City**<br>2. Select **Giza** | • List shows Cairo, Giza, Alexandria, Mansoura, Tanta, Aswan<br>• "Giza" is shown in the field | Planned |
| TC-CHK-010 | Address too short | Negative | P2 | On Checkout | 1. Address `Cairo`<br>2. Tap **Place order** | "Please enter the full address" | Planned |
| TC-CHK-011 | Address boundary – exactly 10 characters | Edge | P3 | On Checkout | 1. Address `12 Nile St`<br>2. Fill the rest validly<br>3. Tap **Place order** | No address error; order is placed | Planned |
| TC-CHK-012 | Delivery date range | Edge | P1 | On Checkout | 1. Tap **Delivery date**<br>2. Check today, yesterday, tomorrow, tomorrow+13, tomorrow+14 | • Picker title "Select delivery date"<br>• Today and past dates are disabled<br>• Tomorrow … tomorrow+13 are selectable<br>• Tomorrow+14 and later are disabled | Planned |
| TC-CHK-013 | Selected date is displayed formatted | UI | P2 | On Checkout | 1. Pick a date and confirm | Field shows the date as `Ddd, D Mmm YYYY` (e.g. "Wed, 21 Oct 2026") | Planned |
| TC-CHK-014 | Cancel the date picker | Edge | P3 | On Checkout, no date selected | 1. Open the date picker<br>2. Tap **Cancel** | Field still shows "Select a date" | Planned |
| TC-CHK-015 | Time slot is single choice | UI | P2 | On Checkout | 1. Tap **5 PM - 9 PM**<br>2. Tap **9 AM - 1 PM** | Only the last tapped slot is selected | Planned |
| TC-CHK-016 | Payment method is single choice | UI | P2 | On Checkout | 1. Tap **Card on delivery**<br>2. Tap **Cash on delivery** | Only the last tapped option is selected | Planned |
| TC-CHK-017 | Notes limited to 120 characters | Edge | P3 | On Checkout | 1. Type 125 characters into Delivery notes | • Only 120 characters are accepted<br>• Counter shows "120/120" | Planned |
| TC-CHK-018 | Summary and button match the cart total | Positive | P1 | Cart: 2 × Wireless Headphones, 1 × Bluetooth Speaker | 1. Open Checkout<br>2. Scroll to Order summary | • Subtotal EGP 6,297, Delivery EGP 50, Total EGP 6,347<br>• Button "Place order · EGP 6,347" | Planned |
| TC-CHK-019 | Double tap on Place order creates one order | Edge | P2 | First order of the session, valid form | 1. Tap **Place order** twice quickly | • Only one order is created (order number ORD-1001)<br>• Next order in the session gets ORD-1002 | Planned |
| TC-CHK-020 | Errors clear after fixing and resubmitting | Positive | P2 | TC-CHK-004 executed (errors visible) | 1. Fill all fields with valid data<br>2. Tap **Place order** | All error messages disappear and the order is placed | Planned |
| TC-CHK-021 | Back from checkout keeps the cart | Positive | P2 | On Checkout with some fields filled | 1. Tap AppBar back | • Cart is shown with the same items<br>• Re-opening Checkout shows an empty form (except pre-filled name) | Planned |
| TC-CHK-022 | Name is pre-filled for a newly registered user | Positive | P3 | Logged in as a new account "Nouran Test", cart has items | 1. Open Checkout | Full name shows "Nouran Test" | Planned |
| TC-CHK-023 | Saved address is reused on next checkout | Negative | P3 | Previous order placed with **Save this address** checked | 1. Add an item<br>2. Open Checkout | Address/city/phone should be pre-filled — ❌ currently empty (**BUG-03**) | Planned |

[← Back to test plan](README.md)
