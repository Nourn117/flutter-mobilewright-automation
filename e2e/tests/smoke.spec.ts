import { validCheckout } from '../src/data/checkout';
import { products } from '../src/data/products';
import { users } from '../src/data/users';
import { test } from '../src/fixtures/test';

/**
 * Framework check: one test per layer of the app.
 * Full coverage of the test plan comes in Phase 5.
 */
test.describe('Smoke', { tag: '@smoke' }, () => {
  test('TC-GEN-001 · app launch shows the Login screen', async ({ loginPage }) => {
    await loginPage.expectLoaded();
  });

  test('TC-LOGIN-001 · login with valid credentials', async ({ loginPage, homePage, productsPage }) => {
    await loginPage.expectLoaded();
    await loginPage.loginAs(users.standard);
    await homePage.expectLoaded();
    await productsPage.expectLoaded();
    await productsPage.expectGreeting('Test');
  });

  test('TC-LOGIN-005 · locked account cannot log in', async ({ loginPage }) => {
    await loginPage.loginAs(users.locked);
    await loginPage.expectError('This account is locked');
  });

    test('TC-E2E-SMOKE · add to cart and place an order', async ({
      loggedIn: home,
      shopping,
      cartPage,
      checkoutPage,
      orderSuccessPage,
    }) => {
      test.slow();
      const subtotal = products.speaker.price * 2;

      await shopping.addToCart(products.speaker, 2, 'go-to-cart');
      await home.expectCartBadge(2);
      await cartPage.expectItem(products.speaker, 2);
      await cartPage.expectTotals(subtotal);

      await cartPage.proceedToCheckout();
      await checkoutPage.expectLoaded();
      await checkoutPage.fillForm(validCheckout);
      await checkoutPage.placeOrder();

      await orderSuccessPage.expectLoaded();
      await orderSuccessPage.expectOrderNumber('ORD-1001');
      await orderSuccessPage.backToShopping();
      await home.expectCartBadge(0);
    });
});
