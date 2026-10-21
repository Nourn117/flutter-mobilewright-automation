import { products } from '../src/data/products';
import { users } from '../src/data/users';
import { expect, test } from '../src/fixtures/test';

/** Profile – docs/test-cases/profile.md */
test.describe('Profile', () => {
  test('TC-PROF-001 · profile shows user data', { tag: '@P1' }, async ({ loggedIn: home, profilePage }) => {
    await home.openProfile();
    await profilePage.expectUser(users.standard);
  });

  test('TC-PROF-002 · turn dark mode on', { tag: '@P2' }, async ({ loggedIn: home, profilePage, productsPage }) => {
    await home.openProfile();
    await profilePage.setDarkMode(true);
    await profilePage.expectDarkMode(true);
    await home.openShop();
    await expect(productsPage.heading).toBeVisible();
  });

  test('TC-PROF-003 · turn dark mode off', { tag: '@P3' }, async ({ loggedIn: home, profilePage }) => {
    await home.openProfile();
    await profilePage.setDarkMode(true);
    await profilePage.setDarkMode(false);
    await profilePage.expectDarkMode(false);
  });

  test('TC-PROF-004 · logout confirmation dialog', { tag: '@P2' }, async ({ loggedIn: home, profilePage }) => {
    await home.openProfile();
    await profilePage.openLogoutDialog();
    await profilePage.expectMessage('Your cart will be cleared.');
    await expect(profilePage.cancelLogoutButton).toBeVisible();
    await expect(profilePage.confirmLogoutButton).toBeVisible();
  });

  test('TC-PROF-005 · cancel logout', { tag: '@P2' }, async ({ loggedIn: home, shopping, profilePage }) => {
    await shopping.addToCart(products.speaker, 2);
    await home.openProfile();
    await profilePage.cancelLogout();
    await profilePage.expectUser(users.standard);
    await home.expectCartBadge(2);
  });

  test('TC-PROF-006 · confirm logout', { tag: '@P1' }, async ({ loggedIn: home, shopping, profilePage, loginPage, cartPage }) => {
    await shopping.addToCart(products.speaker, 1);
    await home.openProfile();
    await profilePage.setDarkMode(true);
    await profilePage.logout();
    await loginPage.expectLoaded();

    await loginPage.loginAs(users.standard);
    await home.openCart();
    await cartPage.expectEmpty();
    await home.openProfile();
    await profilePage.expectDarkMode(false);
  });

  test('TC-PROF-007 · back after logout does not return to Home', { tag: '@P2' }, async ({ loggedIn: home, profilePage, loginPage }) => {
    await home.openProfile();
    await profilePage.logout();
    await loginPage.expectLoaded();
    await loginPage.pressBack();
    await expect(home.shopTab).toBeHidden();
  });
});
