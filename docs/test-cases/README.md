# Test Plan – ShopQA (Flutter app under test)

Manual test design for the ShopQA Android app. Every test case has a unique ID that will be referenced by the Mobilewright automated tests, so each automated test can be traced back to its test case.

## Scope

**In scope:** Login, Register, bottom navigation, Shop (product list & search), Product details, Cart, Checkout, Order success, Profile (dark mode & logout), end-to-end journeys and general checks.

**Out of scope:** backend/API testing (the app uses in-memory mock data), performance and security testing, iOS.

## Test Environment

| Item | Value |
|---|---|
| Platform | Android emulator (Pixel 9, API 35) |
| App package | `com.nouran.mobilewright_demo_app` |
| Build | Debug build from `main` |
| Data | In-memory mock data, reset on every app launch |

## Test Accounts

| Email | Password | Behaviour |
|---|---|---|
| `test@demo.com` | `Test@1234` | Valid user (name "Test User") |
| `locked@demo.com` | `Test@1234` | Locked – login fails with "This account is locked" |

## Business Rules Under Test

- Prices are in EGP, formatted as `EGP 2,499`.
- Delivery fee is a flat **EGP 50** (0 when the cart is empty). Total = Subtotal + Delivery.
- Quantity per product is between **1** and **10**.
- Mobile number: 11 digits starting with **010, 011, 012 or 015**.
- Delivery date: from **tomorrow** up to **14 days** ahead.
- Order numbers are sequential per app session: `ORD-1001`, `ORD-1002`, …

## Conventions

| Field | Values |
|---|---|
| ID | `TC-<MODULE>-<NNN>` |
| Type | Positive, Negative, Edge, UI |
| Priority | **P1** critical (smoke), **P2** important (regression), **P3** nice to have |
| Automation | **Planned** = will be automated with Mobilewright, **Manual** = manual only |

## Coverage Summary

| Module | Total | P1 | P2 | P3 | Planned automation |
|---|---|---|---|---|---|
| [Login](login.md) | 18 | 5 | 9 | 4 | 18 |
| [Register](register.md) | 19 | 6 | 5 | 8 | 18 |
| [Home & Navigation](navigation.md) | 7 | 3 | 2 | 2 | 7 |
| [Shop (Products)](products.md) | 14 | 5 | 4 | 5 | 14 |
| [Product Details](product-details.md) | 14 | 6 | 6 | 2 | 14 |
| [Cart](cart.md) | 16 | 6 | 7 | 3 | 15 |
| [Checkout](checkout.md) | 23 | 7 | 10 | 6 | 23 |
| [Order Success](order-success.md) | 6 | 3 | 3 | 0 | 6 |
| [Profile](profile.md) | 7 | 2 | 4 | 1 | 7 |
| [End-to-End Journeys](end-to-end.md) | 5 | 3 | 2 | 0 | 5 |
| [General & Non-functional](general.md) | 6 | 1 | 0 | 5 | 3 |
| **Total** | **135** | **47** | **52** | **36** | **130** |

## Test Suites

- **Smoke:** all **P1** test cases – run on every pull request.
- **Regression:** P1 + P2 – run before merging to `main`.
- **Full:** all test cases.

## Known Issues Found During Test Design

| ID | Severity | Summary | Test case |
|---|---|---|---|
| BUG-01 | Medium | Adding the same product repeatedly from Details lets the cart quantity exceed the 10-item limit (e.g. 10 + 5 = 15). | TC-DET-013 |
| BUG-02 | Low | Cart summary shows "Subtotal (1 items)" instead of "Subtotal (1 item)". | TC-CART-011 |
| BUG-03 | Low | "Save this address for next time" has no effect; the next checkout form is empty. | TC-CHK-023 |

## Observations

| ID | Observation |
|---|---|
| OBS-01 | Email comparison at login is case-sensitive (`TEST@demo.com` fails). Confirm with product owner whether this is intended. |
| OBS-02 | Search matches product **names** only, not categories. |
| OBS-03 | The products error/retry state cannot be reached because the mock data source never fails. Needs a failure toggle to be testable. |
| OBS-04 | All data (new accounts, cart, order numbers, theme) is in-memory and resets when the app restarts. |
