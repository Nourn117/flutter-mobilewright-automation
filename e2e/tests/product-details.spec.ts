import { MAX_QUANTITY, products } from '../src/data/products';
import { expect, test } from '../src/fixtures/test';

/** Product Details – docs/test-cases/product-details.md */
test.describe('Product Details', () => {
  test('TC-DET-001 · details show correct product data', { tag: '@P1' }, async ({ loggedIn, productsPage, detailsPage }) => {
    await productsPage.openProduct(products.smartWatch);
    await detailsPage.expectProduct(products.smartWatch);
    await detailsPage.expectDescriptionSection();
  });

  test('TC-DET-002 · default quantity is 1 and minus is disabled', { tag: '@P2' }, async ({ loggedIn, productsPage, detailsPage }) => {
    await productsPage.openProduct(products.speaker);
    await detailsPage.expectQuantity(1);
    await expect(detailsPage.minusButton).toBeDisabled();
  });

  test('TC-DET-003 · increase quantity updates button total', { tag: '@P1' }, async ({ loggedIn, productsPage, detailsPage }) => {
    await productsPage.openProduct(products.headphones);
    await detailsPage.increase(2);
    await detailsPage.expectQuantity(3);
    await detailsPage.expectAddButtonTotal(products.headphones.price * 3);
  });

  test('TC-DET-004 · decrease quantity', { tag: '@P2' }, async ({ loggedIn, productsPage, detailsPage }) => {
    await productsPage.openProduct(products.headphones);
    await detailsPage.setQuantity(3);
    await detailsPage.decrease();
    await detailsPage.expectQuantity(2);
    await detailsPage.expectAddButtonTotal(products.headphones.price * 2);
  });

  test('TC-DET-005 · maximum quantity is 10', { tag: '@P2' }, async ({ loggedIn, productsPage, detailsPage }) => {
    await productsPage.openProduct(products.usbHub);
    await detailsPage.setQuantity(MAX_QUANTITY);
    await expect(detailsPage.plusButton).toBeDisabled();
  });

  test('TC-DET-006 · add to cart shows the confirmation sheet', { tag: '@P1' }, async ({ loggedIn: home, productsPage, detailsPage, addedSheet }) => {
    await productsPage.openProduct(products.headphones);
    await detailsPage.addToCart();
    await addedSheet.expectShown(products.headphones, 1);
    await expect(addedSheet.keepShoppingButton).toBeVisible();
    await expect(addedSheet.goToCartButton).toBeVisible();
    await addedSheet.keepShopping();
    await home.expectCartBadge(1);
  });

  test('TC-DET-007 · keep shopping returns to Shop', { tag: '@P1' }, async ({ loggedIn: home, shopping, productsPage }) => {
    await shopping.addToCart(products.headphones, 1, 'keep-shopping');
    await expect(productsPage.heading).toBeVisible();
    await home.expectCartBadge(1);
  });

  test('TC-DET-008 · go to cart opens the Cart tab', { tag: '@P1' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.addToCart(products.headphones, 2, 'go-to-cart');
    await expect(cartPage.title).toBeVisible();
    await cartPage.expectItem(products.headphones, 2);
  });

  test('TC-DET-009 · dismiss the sheet without choosing', { tag: '@P3' }, async ({ loggedIn: home, productsPage, detailsPage, addedSheet, cartPage }) => {
    await productsPage.openProduct(products.speaker);
    await detailsPage.setQuantity(3);
    await detailsPage.addToCart();
    await addedSheet.expectShown(products.speaker, 3);
    await addedSheet.dismiss();

    await detailsPage.expectProduct(products.speaker);
    await detailsPage.expectQuantity(1);

    await detailsPage.pressBack();
    await home.openCart();
    await cartPage.expectItem(products.speaker, 3);
  });

  test('TC-DET-010 · add with quantity greater than 1', { tag: '@P2' }, async ({ loggedIn: home, shopping }) => {
    await shopping.addToCart(products.speaker, 3);
    await home.expectCartBadge(3);
  });

  test('TC-DET-011 · adding the same product twice merges quantity', { tag: '@P1' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.addToCart(products.laptopStand, 1, 'keep-shopping');
    await shopping.addToCart(products.laptopStand, 2, 'go-to-cart');
    await cartPage.expectItem(products.laptopStand, 3);
  });

  test('TC-DET-012 · different products create separate rows', { tag: '@P2' }, async ({ loggedIn, shopping, cartPage }) => {
    await shopping.fillCart([
      { product: products.usbHub, quantity: 1 },
      { product: products.fitnessBand, quantity: 1 },
    ]);
    await cartPage.expectItem(products.usbHub, 1);
    await cartPage.expectItem(products.fitnessBand, 1);
  });

  test('TC-DET-013 · cart quantity is capped at 10 when adding repeatedly (BUG-01)', {
    tag: ['@P2', '@known-bug'],
    annotation: { type: 'issue', description: 'BUG-01: repeated add-to-cart lets the quantity exceed 10' },
  }, async ({ loggedIn, shopping, cartPage }) => {
    test.fail();
    await shopping.addToCart(products.smartWatch, MAX_QUANTITY, 'keep-shopping');
    await shopping.addToCart(products.smartWatch, 5, 'go-to-cart');
    await cartPage.expectItem(products.smartWatch, MAX_QUANTITY);
  });

  test('TC-DET-014 · back from details keeps the search', { tag: '@P3' }, async ({ loggedIn, productsPage, detailsPage }) => {
    await productsPage.searchFor('wireless');
    await productsPage.openProduct(products.earbuds);
    await detailsPage.pressBack();
    await expect(productsPage.search).toHaveText('wireless');
    await productsPage.expectProduct(products.headphones);
    await productsPage.expectProductNotListed(products.speaker);
  });
});
