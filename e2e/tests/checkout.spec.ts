import { DELIVERY_FEE, cities, paymentLabels, slotLabels, validCheckout } from '../src/data/checkout';
import { Messages } from '../src/data/messages';
import { products } from '../src/data/products';
import { newUser, users } from '../src/data/users';
import { expect, test } from '../src/fixtures/test';
import { formatDate, tomorrow } from '../src/utils/dates';

/** Checkout – docs/test-cases/checkout.md */
const watchCart = [{ product: products.smartWatch, quantity: 1 }];
const watchTotal = products.smartWatch.price + DELIVERY_FEE; // EGP 6,049

test.describe('Checkout', () => {
  test.describe.configure({ timeout: 240_000 });

  test('TC-CHK-001 · checkout default state', { tag: '@P1' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.expectFieldValue('fullName', users.standard.name);
    await checkoutPage.expectFieldValue('phone', '');
    await checkoutPage.expectFieldValue('address', '');
    await checkoutPage.expectDeliveryDateText('Select a date');
    await checkoutPage.expectFieldValue('notes', '');
    await checkoutPage.expectTotal(watchTotal);
  });

  test('TC-CHK-002 · place order with valid data', { tag: '@P1' }, async ({ loggedIn: home, checkoutFlow, orderSuccessPage }) => {
    await checkoutFlow.placeOrder(watchCart);
    await orderSuccessPage.expectTotal(watchTotal);
    await orderSuccessPage.backToShopping();
    await home.expectCartBadge(0);
  });

  test('TC-CHK-003 · evening slot and card payment', { tag: '@P1' }, async ({ loggedIn, checkoutFlow, orderSuccessPage }) => {
    await checkoutFlow.placeOrder(watchCart, {
      ...validCheckout,
      slot: 'evening',
      payment: 'card',
      notes: 'Call before arriving',
      saveAddress: true,
    });
    await orderSuccessPage.expectSummary({ slot: slotLabels.evening, payment: paymentLabels.card });
  });

  test('TC-CHK-004 · submit with all required fields empty', { tag: '@P1' }, async ({ loggedIn, checkoutFlow, checkoutPage, orderSuccessPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillFullName('');
    await checkoutPage.placeOrder();
    for (const message of [
      Messages.validation.nameRequired,
      Messages.validation.phoneRequired,
      Messages.validation.cityRequired,
      Messages.validation.addressRequired,
      Messages.validation.dateRequired,
    ]) {
      await checkoutPage.expectMessage(message);
    }
    await expect(orderSuccessPage.title).toBeHidden();
  });

  test('TC-CHK-005 · name shorter than 3 characters', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillForm({ ...validCheckout, fullName: 'Ab' });
    await checkoutPage.placeOrder();
    await checkoutPage.expectMessage(Messages.validation.nameTooShort);
  });

  for (const phone of ['01312345678', '0101234567', '010-1234567']) {
    test(`TC-CHK-006 · invalid mobile number "${phone}"`, { tag: '@P1' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
      await checkoutFlow.openCheckoutWith(watchCart);
      await checkoutPage.fillPhone(phone);
      await checkoutPage.placeOrder();
      await checkoutPage.expectMessage(Messages.validation.phoneInvalid);
    });
  }

  for (const phone of ['01012345678', '01112345678', '01212345678', '01512345678']) {
    test(`TC-CHK-007 · valid mobile prefix "${phone.slice(0, 3)}"`, { tag: '@P2' }, async ({ loggedIn, checkoutFlow }) => {
      await checkoutFlow.placeOrder(watchCart, { ...validCheckout, phone });
    });
  }

  test('TC-CHK-008 · mobile number limited to 11 digits', { tag: '@P3' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillPhone('010123456789');
    await checkoutPage.expectFieldValue('phone', '01012345678');
  });

  test('TC-CHK-009 · city dropdown options', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.openCityDropdown();
    for (const city of cities) await checkoutPage.expectMessage(city);
    await checkoutPage.pressBack();
    await checkoutPage.selectCity('Giza');
    await checkoutPage.expectCity('Giza');
  });

  test('TC-CHK-010 · address too short', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillAddress('Cairo');
    await checkoutPage.placeOrder();
    await checkoutPage.expectMessage(Messages.validation.addressTooShort);
  });

  test('TC-CHK-011 · address boundary – exactly 10 characters', { tag: '@P3' }, async ({ loggedIn, checkoutFlow }) => {
    await checkoutFlow.placeOrder(watchCart, { ...validCheckout, address: '12 Nile St' });
  });

  test.fixme('TC-CHK-012 · delivery date range', { tag: '@P1' }, async () => {
    // Disabled days in the Material date picker are a visual check. Covered manually.
  });

  test('TC-CHK-013 · selected date is displayed formatted', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.pickEarliestDeliveryDate();
    await checkoutPage.expectDeliveryDateText(formatDate(tomorrow()));
  });

  test('TC-CHK-014 · cancel the date picker', { tag: '@P3' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.openDatePicker();
    await checkoutPage.cancelDatePicker();
    await checkoutPage.expectDeliveryDateText('Select a date');
  });

  test('TC-CHK-015 · time slot is single choice', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage, orderSuccessPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillForm(validCheckout);
    await checkoutPage.selectSlot('evening');
    await checkoutPage.selectSlot('morning');
    await checkoutPage.placeOrder();
    await orderSuccessPage.expectSummary({ slot: slotLabels.morning, payment: paymentLabels.cash });
  });

  test('TC-CHK-016 · payment method is single choice', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage, orderSuccessPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillForm(validCheckout);
    await checkoutPage.selectPayment('card');
    await checkoutPage.selectPayment('cash');
    await checkoutPage.placeOrder();
    await orderSuccessPage.expectSummary({ slot: slotLabels.morning, payment: paymentLabels.cash });
  });

  test('TC-CHK-017 · notes limited to 120 characters', { tag: '@P3' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    const longNote = 'a'.repeat(125);
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillNotes(longNote);
    await checkoutPage.expectFieldValue('notes', longNote.slice(0, 120));
  });

  test('TC-CHK-018 · summary and button match the cart total', { tag: '@P1' }, async ({ loggedIn, checkoutFlow, checkoutPage }) => {
    await checkoutFlow.openCheckoutWith([
      { product: products.headphones, quantity: 2 },
      { product: products.speaker, quantity: 1 },
    ]);
    await checkoutPage.expectTotal(6347); // 6,297 + 50
  });

  test('TC-CHK-019 · double tap on Place order creates one order', { tag: '@P2' }, async ({
    loggedIn,
    checkoutFlow,
    checkoutPage,
    orderSuccessPage,
  }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillForm(validCheckout);
    await checkoutPage.placeOrderTwice();
    await orderSuccessPage.expectLoaded();
    await orderSuccessPage.expectOrderNumber('ORD-1001');

    await orderSuccessPage.backToShopping();
    await checkoutFlow.placeOrder(watchCart);
    await orderSuccessPage.expectOrderNumber('ORD-1002');
  });

  test('TC-CHK-020 · errors clear after fixing and resubmitting', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage, orderSuccessPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.placeOrder();
    await checkoutPage.expectMessage(Messages.validation.phoneRequired);
    await checkoutFlow.completeOrder();
    await orderSuccessPage.expectLoaded();
  });

  test('TC-CHK-021 · back from checkout keeps the cart', { tag: '@P2' }, async ({ loggedIn, checkoutFlow, checkoutPage, cartPage }) => {
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.fillPhone(validCheckout.phone);
    await checkoutPage.pressBack();
    await cartPage.expectItem(products.smartWatch, 1);

    await cartPage.proceedToCheckout();
    await checkoutPage.expectFieldValue('fullName', users.standard.name);
    await checkoutPage.expectFieldValue('phone', '');
  });

  test('TC-CHK-022 · name is pre-filled for a newly registered user', { tag: '@P3' }, async ({
    loginPage,
    registerPage,
    homePage,
    checkoutFlow,
    checkoutPage,
  }) => {
    const user = newUser({ name: 'Nouran Test' });
    await loginPage.expectLoaded();
    await loginPage.goToRegister();
    await registerPage.registerUser(user);
    await registerPage.confirmSuccess();
    await loginPage.fillPassword(user.password);
    await loginPage.submit();
    await homePage.expectLoaded();

    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.expectFieldValue('fullName', user.name);
  });

  test('TC-CHK-023 · saved address is reused on next checkout (BUG-03)', {
    tag: ['@P3', '@known-bug'],
    annotation: { type: 'issue', description: 'BUG-03: "Save this address" has no effect' },
  }, async ({ loggedIn, checkoutFlow, checkoutPage, orderSuccessPage }) => {
    test.fail();
    await checkoutFlow.placeOrder(watchCart, { ...validCheckout, saveAddress: true });
    await orderSuccessPage.backToShopping();
    await checkoutFlow.openCheckoutWith(watchCart);
    await checkoutPage.expectFieldValue('address', validCheckout.address);
  });
});
