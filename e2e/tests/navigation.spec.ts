import { products } from '../src/data/products';
import { users } from '../src/data/users';
import { expect, test } from '../src/fixtures/test';

/** Home & Navigation – docs/test-cases/navigation.md */
test.describe('Home & Navigation', () => {
  test('TC-NAV-001 · bottom navigation default state', { tag: '@P1' }, async ({ loggedIn: home, productsPage }) => {
    await expect(home.shopTab).toContainText('Shop');
    await expect(home.cartTab).toContainText('Cart');
    await expect(home.profileTab).toContainText('Profile');
    await expect(productsPage.heading).toBeVisible();
  });

  test('TC-NAV-002 · switch between tabs', { tag: '@P1' }, async ({ loggedIn: home, cartPage, profilePage, productsPage }) => {
    await home.openCart();
    await expect(cartPage.title).toBeVisible();
    await home.openProfile();
    await expect(profilePage.title).toBeVisible();
    await home.openShop();
    await expect(productsPage.heading).toBeVisible();
  });

  test('TC-NAV-003 · cart badge hidden when cart is empty', { tag: '@P2' }, async ({ loggedIn: home }) => {
    await home.expectCartBadge(0);
  });

  test('TC-NAV-004 · cart badge shows total quantity', { tag: '@P1' }, async ({ loggedIn: home, shopping }) => {
    await shopping.addToCart(products.headphones, 2);
    await shopping.addToCart(products.speaker, 1);
    await home.expectCartBadge(3);
  });

  test('TC-NAV-005 · badge updates after cart changes', { tag: '@P2' }, async ({ loggedIn: home, shopping, cartPage }) => {
    await shopping.addToCart(products.headphones, 2, 'go-to-cart');
    await cartPage.increase(products.headphones);
    await home.expectCartBadge(3);
    await cartPage.remove(products.headphones);
    await home.expectCartBadge(0);
  });

  test('TC-NAV-006 · tab state is preserved', { tag: '@P3' }, async ({ loggedIn: home, productsPage }) => {
    await productsPage.searchFor('watch');
    await home.openProfile();
    await home.openShop();
    await expect(productsPage.search).toHaveText('watch');
    await productsPage.expectProduct(products.smartWatch);
    await productsPage.expectProductNotListed(products.headphones);
  });

  test('TC-NAV-007 · Shop tab selected after re-login', { tag: '@P3' }, async ({ loggedIn: home, profilePage, loginPage, productsPage }) => {
    await home.openProfile();
    await profilePage.logout();
    await loginPage.expectLoaded();
    await loginPage.loginAs(users.standard);
    await expect(productsPage.heading).toBeVisible();
  });
});
