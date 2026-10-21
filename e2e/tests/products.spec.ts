import { allProducts, products } from '../src/data/products';
import { expect, test } from '../src/fixtures/test';

/** Shop (Products) – docs/test-cases/products.md */
test.describe('Shop (Products)', () => {
  test('TC-PROD-001 · products load after login', { tag: '@P1' }, async ({ loggedIn, productsPage }) => {
    await productsPage.expectLoaded();
    await productsPage.expectProduct(products.headphones);
    await productsPage.expectProduct(products.earbuds);
  });

  for (const product of allProducts) {
    test(`TC-PROD-002 · card shows correct data – ${product.name}`, { tag: '@P1' }, async ({ loggedIn, productsPage }) => {
      await productsPage.expectProduct(product);
    });
  }

  test('TC-PROD-003 · greeting shows the user first name', { tag: '@P2' }, async ({ loggedIn, productsPage }) => {
    await productsPage.expectGreeting('Test');
    await expect(productsPage.heading).toBeVisible();
  });

  test('TC-PROD-004 · search by full product name', { tag: '@P1' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('Smart Watch');
    await productsPage.expectProduct(products.smartWatch);
    await productsPage.expectProductNotListed(products.headphones);
  });

  test('TC-PROD-005 · search by partial name', { tag: '@P2' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('wireless');
    await productsPage.expectProduct(products.headphones);
    await productsPage.expectProduct(products.earbuds);
    await productsPage.expectProductNotListed(products.speaker);
  });

  test('TC-PROD-006 · search is case-insensitive', { tag: '@P2' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('KEYBOARD');
    await productsPage.expectProduct(products.keyboard);
  });

  test('TC-PROD-007 · search ignores leading/trailing spaces', { tag: '@P3' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('  speaker  ');
    await productsPage.expectProduct(products.speaker);
  });

  test('TC-PROD-008 · search with no results', { tag: '@P1' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('laptop pro max');
    await productsPage.expectNoResults();
  });

  test('TC-PROD-009 · search does not match by category (OBS-02)', { tag: '@P3' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('Audio');
    await productsPage.expectNoResults();
  });

  test('TC-PROD-010 · clearing search restores all products', { tag: '@P2' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('watch');
    await productsPage.expectProductNotListed(products.headphones);
    await productsPage.clearSearch();
    await productsPage.expectProduct(products.headphones);
    await productsPage.expectProduct(products.earbuds);
  });

  test('TC-PROD-011 · search with special characters', { tag: '@P3' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('@#$%');
    await productsPage.expectNoResults();
  });

  test('TC-PROD-012 · search with hyphen', { tag: '@P3' }, async ({ loggedIn, productsPage }) => {
    await productsPage.searchFor('usb-c');
    await productsPage.expectProduct(products.usbHub);
  });

  test('TC-PROD-013 · open product details', { tag: '@P1' }, async ({ loggedIn, productsPage, detailsPage }) => {
    await productsPage.openProduct(products.smartWatch);
    await detailsPage.expectProduct(products.smartWatch);
  });

  test('TC-PROD-014 · scroll to the last product', { tag: '@P3' }, async ({ loggedIn, productsPage }) => {
    await productsPage.expectProduct(products.earbuds);
    await expect(productsPage.card(products.earbuds)).toBeVisible();
  });
});
