# Shop (Products)

Covers the product grid, product data, search and navigation to details.

## Test Data – Product Catalogue

| ID | Name | Category | Price |
|---|---|---|---|
| p1 | Wireless Headphones | Audio | EGP 2,499 |
| p2 | Smart Watch | Wearables | EGP 5,999 |
| p3 | Bluetooth Speaker | Audio | EGP 1,299 |
| p4 | Laptop Stand | Accessories | EGP 899 |
| p5 | USB-C Hub | Accessories | EGP 749 |
| p6 | Mechanical Keyboard | Accessories | EGP 2,199 |
| p7 | Fitness Band | Wearables | EGP 1,499 |
| p8 | Wireless Earbuds | Audio | EGP 1,899 |

## Test Cases

| ID | Scenario | Type | Priority | Preconditions | Steps | Expected Result | Automation |
|---|---|---|---|---|---|---|---|
| TC-PROD-001 | Products load after login | Positive | P1 | Just logged in | 1. Observe the Shop tab | • Loading spinner is shown briefly<br>• Grid with **8** products is displayed (2 columns) | Planned |
| TC-PROD-002 | Product cards show correct data (data-driven) | Positive | P1 | Logged in as `test@demo.com` | 1. For each product in the catalogue table, find its card | Card shows the correct name, category and price in `EGP x,xxx` format | Planned |
| TC-PROD-003 | Greeting shows the user's first name | UI | P2 | Logged in as `test@demo.com` | 1. Observe the header | • "Hello, Test 👋"<br>• Title "Find your next gadget" | Planned |
| TC-PROD-004 | Search by full product name | Positive | P1 | Logged in as `test@demo.com` | 1. Type `Smart Watch` in search | Only **Smart Watch** is displayed | Planned |
| TC-PROD-005 | Search by partial name | Positive | P2 | Logged in as `test@demo.com` | 1. Type `wireless` | Only **Wireless Headphones** and **Wireless Earbuds** are displayed | Planned |
| TC-PROD-006 | Search is case-insensitive | Positive | P2 | Logged in as `test@demo.com` | 1. Type `KEYBOARD` | **Mechanical Keyboard** is displayed | Planned |
| TC-PROD-007 | Search ignores leading/trailing spaces | Edge | P3 | Logged in as `test@demo.com` | 1. Type `  speaker  ` | **Bluetooth Speaker** is displayed | Planned |
| TC-PROD-008 | Search with no results | Negative | P1 | Logged in as `test@demo.com` | 1. Type `laptop pro max` | • Empty state "No products found"<br>• Message "Try a different search term." | Planned |
| TC-PROD-009 | Search does not match by category | Edge | P3 | Logged in as `test@demo.com` | 1. Type `Audio` | "No products found" (search matches product names only, see OBS-02) | Planned |
| TC-PROD-010 | Clearing search restores all products | Positive | P2 | Search `watch` applied | 1. Clear the search field | All **8** products are displayed again | Planned |
| TC-PROD-011 | Search with special characters | Negative | P3 | Logged in as `test@demo.com` | 1. Type `@#$%` | "No products found"; app does not crash | Planned |
| TC-PROD-012 | Search with hyphen | Edge | P3 | Logged in as `test@demo.com` | 1. Type `usb-c` | **USB-C Hub** is displayed | Planned |
| TC-PROD-013 | Open product details | Positive | P1 | Logged in as `test@demo.com` | 1. Tap the **Smart Watch** card | Details screen for Smart Watch opens | Planned |
| TC-PROD-014 | Scroll to the last product | UI | P3 | Logged in as `test@demo.com` | 1. Scroll the grid to the bottom | **Wireless Earbuds** card is fully visible | Planned |

[← Back to test plan](README.md)
