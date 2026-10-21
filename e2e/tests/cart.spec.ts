import { products, MAX_QUANTITY } from '../src/data/products';
import { users } from '../src/data/users';
import { expect, test } from '../src/fixtures/test';
import { formatPrice } from '../src/utils/format';

/** Cart – docs/test-cases/cart.md */
test.describe('Cart', () => {
  test('TC-CART-001 · empty cart state', { tag: '@P1' }, async ({ loggedIn: home, cartPage }) => {
    await home.openCart();
    await cartPage.expectEmpty();
    await expect(cartPage.startShoppingButton).toBeVisible();
  });

  test('TC-CART-002 · start shopping goes to Shop', { tag: '@P2' }, async ({ loggedIn: home, cartPage, productsPage }) => {
    await home.openCart();
    await cartPage.startShopping();
    await expect(productsPage.heading).toBeVisible();
  });

  test('TC-CART-003 · cart item shows correct data', { tag: '@P1' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.addToCart(products.headphones, 2, 'go-to-cart');
    await cartPage.expectItem(products.headphones, 2);
    await cartPage.expectMessage(products.headphones.name);
    await cartPage.expectMessage(formatPrice(products.headphones.price));
  });

  test('TC-CART-004 · increase quantity in cart', { tag: '@P1' }, async ({ loggedIn: home, shopping, cartPage }) => {
    await shopping.addToCart(products.speaker, 1, 'go-to-cart');
    await cartPage.increase(products.speaker);
    await cartPage.expectItem(products.speaker, 2);
    await cartPage.expectTotals(products.speaker.price * 2);
    await home.expectCartBadge(2);
  });

  test('TC-CART-005 · decrease quantity in cart', { tag: '@P2' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.addToCart(products.speaker, 3, 'go-to-cart');
    await cartPage.decrease(products.speaker);
    await cartPage.expectItem(products.speaker, 2);
    await cartPage.expectTotals(products.speaker.price * 2);
  });

  test('TC-CART-006 · minus disabled at quantity 1', { tag: '@P2' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.addToCart(products.usbHub, 1, 'go-to-cart');
    await expect(cartPage.minusButton(products.usbHub)).toBeDisabled();
  });

  test('TC-CART-007 · plus disabled at quantity 10', { tag: '@P2' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.addToCart(products.usbHub, MAX_QUANTITY - 1, 'go-to-cart');
    await cartPage.increase(products.usbHub);
    await cartPage.expectItem(products.usbHub, MAX_QUANTITY);
    await expect(cartPage.plusButton(products.usbHub)).toBeDisabled();
  });

  test('TC-CART-008 · remove one item', { tag: '@P1' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.fillCart([
      { product: products.headphones, quantity: 1 },
      { product: products.speaker, quantity: 1 },
    ]);
    await cartPage.remove(products.headphones);
    await cartPage.expectNoItem(products.headphones);
    await cartPage.expectTotals(products.speaker.price);
  });

  test('TC-CART-009 · remove the last item', { tag: '@P2' }, async ({ loggedIn: home, shopping, cartPage }) => {
    await shopping.addToCart(products.speaker, 1, 'go-to-cart');
    await cartPage.remove(products.speaker);
    await cartPage.expectEmpty();
    await home.expectCartBadge(0);
  });

  test('TC-CART-010 · order summary calculation', { tag: '@P1' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.fillCart([
      { product: products.headphones, quantity: 2 },
      { product: products.speaker, quantity: 1 },
    ]);
    await cartPage.expectSubtotalLabel('Subtotal (3 items)');
    await cartPage.expectTotals(6297); // 2 × 2,499 + 1,299
  });

  test('TC-CART-011 · subtotal label with a single item (BUG-02)', {
    tag: ['@P3', '@known-bug'],
    annotation: { type: 'issue', description: 'BUG-02: shows "Subtotal (1 items)"' },
  }, async ({ loggedIn, shopping, cartPage }) => {
    test.fail();
    await shopping.addToCart(products.speaker, 1, 'go-to-cart');
    await cartPage.expectSubtotalLabel('Subtotal (1 item)');
  });

  test('TC-CART-012 · proceed to checkout', { tag: '@P1' }, async ({ loggedIn, shopping, cartPage, checkoutPage }) => {
    await shopping.addToCart(products.speaker, 1, 'go-to-cart');
    await cartPage.proceedToCheckout();
    await checkoutPage.expectLoaded();
  });

  test('TC-CART-013 · cart persists across tabs', { tag: '@P2' }, async ({ loggedIn: home, shopping, cartPage }) => {
    await shopping.addToCart(products.keyboard, 2, 'go-to-cart');
    await home.openProfile();
    await home.openCart();
    await cartPage.expectItem(products.keyboard, 2);
  });

  test('TC-CART-014 · cart is cleared after logout', { tag: '@P2' }, async ({ loggedIn: home, shopping, profilePage, loginPage, cartPage }) => {
    await shopping.addToCart(products.keyboard, 1);
    await home.openProfile();
    await profilePage.logout();
    await loginPage.loginAs(users.standard);
    await home.openCart();
    await cartPage.expectEmpty();
  });

  test('TC-CART-016 · long cart list scrolls, summary stays visible', { tag: '@P3' }, async ({ loggedIn, shopping, cartPage }) => {
    test.slow();
    await shopping.fillCart(Object.values(products).map((product) => ({ product, quantity: 1 })));
    await cartPage.expectItem(products.earbuds, 1);
    await expect(cartPage.checkoutButton).toBeVisible();
  });
});
