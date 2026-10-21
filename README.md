# Flutter × Mobilewright – Mobile Test Automation

[![E2E (Android)](https://github.com/Nourn117/flutter-mobilewright-automation/actions/workflows/e2e.yml/badge.svg)](https://github.com/Nourn117/flutter-mobilewright-automation/actions/workflows/e2e.yml)

End-to-end UI test automation for **ShopQA**, a Flutter Android shopping app, using **[Mobilewright](https://mobilewright.dev)** (TypeScript, Playwright-style API).

The repository contains the whole testing lifecycle: the app under test, a manual test plan with 135 test cases, an automated suite of 145 tests built on the Page Object Model, and a CI pipeline that runs the smoke suite on an Android emulator for every pull request.

---

## Highlights

| | |
|---|---|
| **Test design** | 135 manual test cases across 11 modules, with priorities, types and traceability IDs |
| **Automation** | 145 automated tests (data-driven cases included), every test linked to its `TC-ID` |
| **Results** | 139 passing · 3 known bugs caught (`test.fail`) · 3 manual-only checks |
| **Suites** | Smoke `@P1` (56) · Regression `@P1` + `@P2` (114) · Full (145) |
| **CI** | GitHub Actions: builds the release APK, boots an emulator and runs the smoke suite on every PR (~25 min) |
| **App** | Flutter, Clean Architecture (data / domain / presentation), Cubit + freezed, get_it, mock data |

---

## Repository structure

```
.
├── lib/                    Flutter app under test (Clean Architecture)
├── test/                   Flutter unit tests (validators, repositories, use cases)
├── docs/test-cases/        Test plan + manual test cases per module
├── e2e/                    Mobilewright automation project (TypeScript)
│   ├── src/
│   │   ├── data/           Test data: users, products, checkout, messages, test ids
│   │   ├── pages/          Page objects (one per screen) + BasePage helpers
│   │   ├── flows/          Multi-screen flows (shopping, checkout)
│   │   ├── fixtures/       Custom `test` with page fixtures and `loggedIn`
│   │   └── utils/          Price/date formatting, debug helpers
│   ├── tests/              Specs, one file per module
│   └── mobilewright.config.ts
└── .github/workflows/      CI pipeline (e2e.yml)
```

---

## The app under test

ShopQA is a small but realistic shopping flow built for testing: **Login → Register → Shop (search) → Product details → Cart → Checkout form → Order success → Profile**.

It uses in-memory mock data, so every app launch starts from the same state and tests are deterministic. Every interactive widget carries a stable test id through Flutter `Semantics(identifier: ...)`, which Android exposes as a resource-id that Mobilewright finds with `getByTestId()`. All ids live in one file (`lib/core/testing/test_ids.dart`) mirrored in `e2e/src/data/test-ids.ts`.

| Account | Password | Behaviour |
|---|---|---|
| `test@demo.com` | `Test@1234` | Valid user |
| `locked@demo.com` | `Test@1234` | Locked account (negative scenario) |

---

## Test strategy

The full test plan is in **[docs/test-cases](docs/test-cases/README.md)**: scope, environment, business rules, conventions and one file per module.

| Module | Test cases | Automated tests |
|---|---|---|
| Login | 18 | 21 |
| Register | 19 | 18 |
| Home & Navigation | 7 | 7 |
| Shop (Products) | 14 | 21 |
| Product Details | 14 | 14 |
| Cart | 16 | 15 |
| Checkout | 23 | 29 |
| Order Success | 6 | 6 |
| Profile | 7 | 7 |
| End-to-End | 5 | 5 |
| General | 6 | 3 |

Automated counts differ from test-case counts because some cases are data-driven (for example 4 invalid emails or 8 product cards) and a few cases are manual-only (restart-dependent or purely visual checks).

**Priorities and tags.** Every test is tagged `@P1` (critical / smoke), `@P2` (regression) or `@P3` (full), and its title starts with the test case ID, for example `TC-CHK-002 · place order with valid data`, so a failure in the report points straight to the documented case.

---

## Bugs found

Three real defects were found while designing the tests. They are kept as **known issues** and their tests are marked `test.fail()` with an `@known-bug` tag: the suite stays green while the bug exists, and the test will flag itself once someone fixes it.

| ID | Severity | Summary | Test |
|---|---|---|---|
| BUG-01 | Medium | Adding the same product repeatedly lets the cart quantity exceed the limit of 10 | `TC-DET-013` |
| BUG-02 | Low | Cart shows "Subtotal (1 items)" instead of "(1 item)" | `TC-CART-011` |
| BUG-03 | Low | "Save this address for next time" has no effect | `TC-CHK-023` |

---

## Automation framework

**Page Object Model.** Each screen has a page class with its locators and actions (`LoginPage.loginAs(user)`, `CartPage.expectTotals(subtotal)`). Tests read like the test cases and contain no raw locators.

**Fixtures.** `e2e/src/fixtures/test.ts` extends Mobilewright's `test` with every page object plus a `loggedIn` fixture, so a test that needs an authenticated user just asks for it:

```ts
test('TC-CART-010 · order summary calculation', { tag: '@P1' }, async ({ loggedIn, shopping, cartPage }) => {
  await shopping.fillCart([
    { product: products.headphones, quantity: 2 },
    { product: products.speaker, quantity: 1 },
  ]);
  await cartPage.expectSubtotalLabel('Subtotal (3 items)');
  await cartPage.expectTotals(6297);
});
```

**Flows.** `ShoppingFlow` and `CheckoutFlow` wrap multi-screen journeys (add to cart, fill cart, place order) that many tests reuse.

**Test data.** Users, products, prices, cities and every UI message live in `e2e/src/data`, so a change in the app means one change in the tests.

**Stability.** Tests run serially on one device, each test starts from a fresh app launch, failed tests retry once locally and twice on CI, and every failure attaches a screenshot plus the screen's element tree.

---

## Running the tests locally

**Prerequisites:** Flutter, Android Studio with an emulator, Node.js 18+. Check the setup with `npx mobilewright doctor`.

```bash
# 1. Build and install the release app (release builds make UI reads much faster)
flutter build apk --release
adb install -r build/app/outputs/flutter-apk/app-release.apk

# 2. Install and run the tests
cd e2e
npm install
npm run typecheck
npm run test:smoke        # @P1 – 56 tests
npm run test:regression   # @P1 + @P2 – 114 tests
npm test                  # everything
npx mobilewright test cart                    # one module
npx mobilewright test --grep "TC-CHK-002"     # one test case
npm run report            # open the HTML report
```

---

## Continuous integration

`.github/workflows/e2e.yml` runs on every pull request to `main` and can be started manually from the Actions tab with a choice of suite (`@P1`, `@P1|@P2`, `all`).

The pipeline frees disk space, builds the release APK, installs the e2e dependencies and type-checks the tests, boots an Android 14 emulator with KVM, warms the app up once (the first launch after install is slow on a GPU-less runner), runs the suite, and publishes the JUnit results as a check plus the HTML report as an artifact.

---

## Lessons learned: Flutter + Mobilewright on Android

These are the problems met while building the suite, and how they were solved. They apply to any Flutter UI automation that goes through the Android accessibility tree.

1. **Use a release build.** Reading the screen from a debug build took ~8 s per action; a release build made the login test go from 1.9 min to 15 s.
2. **Ids sit on wrappers.** `Semantics(identifier)` creates its own node, so texts and states are often on a child node (buttons, switches, cards), or merged onto the wrapper itself (tappable `InkWell`s). Page objects read from the right node for each widget.
3. **Navigation bars merge semantics.** `NavigationBar` merges each tab into one node, so the cart badge got a `semanticsLabel` ("Cart items: 2") to be readable by tests and screen readers.
4. **Give list items a `ValueKey`.** Without keys, Flutter reuses grid elements after filtering and Android can keep the old resource-id on the reused node.
5. **Mind the keyboard.** The keyboard covers fields and sticky buttons, closing it shifts the layout, and Android sets text on the *focused* field. The `BasePage.fill()` helper taps, waits for focus, fills, closes the keyboard and waits for the layout to settle.
6. **Don't trust `scrollIntoViewIfNeeded()` on Android (Mobilewright 0.0.67).** It compares pixel bounds with the screen size in points, so a custom `reveal()` swipes until the element is actually visible.
7. **Long local runs need a fresh emulator.** After ~20 minutes of continuous runs the local emulator's UI service can hang; a cold boot fixes it, and CI always starts from a fresh emulator.

---

## Tech stack

**App:** Flutter · Dart · flutter_bloc (Cubit) · freezed · get_it · Material 3
**Automation:** Mobilewright 0.0.67 · TypeScript · Playwright Test runner
**CI:** GitHub Actions · reactivecircus/android-emulator-runner · JUnit + HTML reports
