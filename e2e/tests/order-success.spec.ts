import { DELIVERY_FEE, paymentLabels, slotLabels, validCheckout } from '../src/data/checkout';
import { Messages } from '../src/data/messages';
import { products } from '../src/data/products';
import { expect, test } from '../src/fixtures/test';
import { formatDate, tomorrow } from '../src/utils/dates';

/** Order Success – docs/test-cases/order-success.md */
const watchCart = [{ product: products.smartWatch, quantity: 1 }];

test.describe('Order Success', () => {
  test.describe.configure({ timeout: 240_000 });

  test('TC-ORD-001 · order success details', { tag: '@P1' }, async ({ loggedIn, checkoutFlow, orderSuccessPage }) => {
    await checkoutFlow.placeOrder(watchCart);
    await expect(orderSuccessPage.title).toHaveText(Messages.orderSuccess.title);
    await orderSuccessPage.expectMessage(
      `Thanks Test, we will deliver to ${validCheckout.city} on ${formatDate(tomorrow())}.`,
    );
    await orderSuccessPage.expectOrderNumber('ORD-1001');
    await orderSuccessPage.expectSummary({ slot: slotLabels.morning, payment: paymentLabels.cash });
    await orderSuccessPage.expectTotal(products.smartWatch.price + DELIVERY_FEE);
  });

  test('TC-ORD-002 · ordered items list', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, orderSuccessPage }) => {
    await checkoutFlow.placeOrder([
      { product: products.headphones, quantity: 2 },
      { product: products.speaker, quantity: 1 },
    ]);
    await orderSuccessPage.expectTotal(6347);
    await orderSuccessPage.expectMessage(products.headphones.name);
    await orderSuccessPage.expectMessage('Qty 2');
    await orderSuccessPage.expectMessage(products.speaker.name);
    await orderSuccessPage.expectMessage('Qty 1');
  });

  test('TC-ORD-003 · order numbers are sequential', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, orderSuccessPage }) => {
    await checkoutFlow.placeOrder(watchCart);
    await orderSuccessPage.expectOrderNumber('ORD-1001');
    await orderSuccessPage.backToShopping();
    await checkoutFlow.placeOrder(watchCart);
    await orderSuccessPage.expectOrderNumber('ORD-1002');
  });

  test('TC-ORD-004 · back to shopping', { tag: '@P1' }, async ({ loggedIn: home, checkoutFlow, orderSuccessPage, productsPage }) => {
    await checkoutFlow.placeOrder(watchCart);
    await orderSuccessPage.backToShopping();
    await expect(productsPage.heading).toBeVisible();
    await home.expectCartBadge(0);
  });

  test('TC-ORD-005 · Android back behaves like Back to shopping', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, orderSuccessPage, productsPage, checkoutPage }) => {
    await checkoutFlow.placeOrder(watchCart);
    await orderSuccessPage.pressBack();
    await expect(productsPage.heading).toBeVisible();
    await expect(checkoutPage.placeOrderButton).toBeHidden();
  });

  test('TC-ORD-006 · cart is empty after placing an order', { tag: '@P1' }, async ({ loggedIn: home, checkoutFlow, orderSuccessPage, cartPage }) => {
    await checkoutFlow.placeOrder(watchCart);
    await orderSuccessPage.backToShopping();
    await home.openCart();
    await cartPage.expectEmpty();
  });
});
