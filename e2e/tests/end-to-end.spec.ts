import { DELIVERY_FEE, paymentLabels, slotLabels, validCheckout } from '../src/data/checkout';
import { Messages } from '../src/data/messages';
import { products } from '../src/data/products';
import { newUser, users } from '../src/data/users';
import { expect, test } from '../src/fixtures/test';

/** End-to-End Journeys – docs/test-cases/end-to-end.md */
test.describe('End-to-End', () => {
  test.describe.configure({ timeout: 300_000 });

  test('TC-E2E-001 · new customer journey', { tag: '@P1' }, async ({
    loginPage,
    registerPage,
    homePage,
    productsPage,
    shopping,
    cartPage,
    checkoutPage,
    orderSuccessPage,
    profilePage,
  }) => {
    const user = newUser();
    await loginPage.expectLoaded();
    await loginPage.goToRegister();
    await registerPage.registerUser(user);
    await registerPage.confirmSuccess();
    await loginPage.fillPassword(user.password);
    await loginPage.submit();
    await homePage.expectLoaded();

    await productsPage.searchFor('watch');
    await shopping.addToCart(products.smartWatch, 2, 'go-to-cart');
    await cartPage.proceedToCheckout();
    await checkoutPage.fillForm(validCheckout);
    await checkoutPage.placeOrder();

    await orderSuccessPage.expectLoaded();
    await orderSuccessPage.expectOrderNumber('ORD-1001');
    await orderSuccessPage.expectTotal(products.smartWatch.price * 2 + DELIVERY_FEE); // EGP 12,048
    await orderSuccessPage.backToShopping();

    await homePage.openProfile();
    await profilePage.logout();
    await loginPage.expectLoaded();
  });

  test('TC-E2E-002 · returning customer edits cart before ordering', { tag: '@P1' }, async ({
    loggedIn,
    shopping,
    cartPage,
    checkoutFlow,
    orderSuccessPage,
  }) => {
    await shopping.fillCart([
      { product: products.headphones, quantity: 1 },
      { product: products.usbHub, quantity: 2 },
      { product: products.fitnessBand, quantity: 1 },
    ]);
    await cartPage.increase(products.headphones);
    await cartPage.remove(products.fitnessBand);
    await cartPage.expectTotals(6496); // 2 × 2,499 + 2 × 749

    await cartPage.proceedToCheckout();
    await checkoutFlow.completeOrder({ ...validCheckout, slot: 'evening', payment: 'card' });
    await orderSuccessPage.expectTotal(6546);
    await orderSuccessPage.expectSummary({ slot: slotLabels.evening, payment: paymentLabels.card });
  });

  test('TC-E2E-003 · two orders in one session', { tag: '@P2' }, async ({ loggedIn: home, checkoutFlow, orderSuccessPage, cartPage }) => {
    const cart = [{ product: products.speaker, quantity: 1 }];
    await checkoutFlow.placeOrder(cart);
    await orderSuccessPage.expectOrderNumber('ORD-1001');
    await orderSuccessPage.backToShopping();

    await checkoutFlow.placeOrder(cart);
    await orderSuccessPage.expectOrderNumber('ORD-1002');
    await orderSuccessPage.backToShopping();
    await home.openCart();
    await cartPage.expectEmpty();
  });

  test('TC-E2E-004 · locked user cannot reach the shop', { tag: '@P1' }, async ({ loginPage, homePage }) => {
    await loginPage.expectLoaded();
    await loginPage.loginAs(users.locked);
    await loginPage.expectError(Messages.auth.accountLocked);
    await expect(homePage.shopTab).toBeHidden();
  });

  test('TC-E2E-005 · cart is isolated between sessions', { tag: '@P2' }, async ({ loggedIn: home, shopping, profilePage, loginPage, cartPage }) => {
    await shopping.addToCart(products.earbuds, 2);
    await home.openProfile();
    await profilePage.logout();
    await loginPage.loginAs(users.standard);
    await home.expectCartBadge(0);
    await home.openCart();
    await cartPage.expectEmpty();
  });
});
