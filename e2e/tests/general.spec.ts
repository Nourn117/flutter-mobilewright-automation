import { products } from '../src/data/products';
import { expect, test } from '../src/fixtures/test';

/** General & Non-functional – docs/test-cases/general.md (003, 005, 006 are manual) */
test.describe('General', () => {
  test('TC-GEN-001 · app launch shows Login', { tag: '@P1' }, async ({ loginPage }) => {
    await loginPage.expectLoaded();
  });

  test('TC-GEN-002 · rotate the device on main screens', { tag: '@P3' }, async ({ loggedIn: home, device, shopping, productsPage, cartPage }) => {
    try {
      await device.setOrientation('landscape');
      await expect(productsPage.search).toBeVisible();
      await device.setOrientation('portrait');

      await shopping.addToCart(products.speaker, 1, 'go-to-cart');
      await device.setOrientation('landscape');
      await expect(cartPage.title).toBeVisible();
      await device.setOrientation('portrait');
      await cartPage.expectItem(products.speaker, 1);
      await home.expectCartBadge(1);
    } finally {
      await device.setOrientation('portrait');
    }
  });

  test('TC-GEN-004 · keyboard does not hide the focused field', { tag: '@P3' }, async ({ loginPage, registerPage }) => {
    await loginPage.expectLoaded();
    await loginPage.goToRegister();
    await registerPage.confirmPassword.tap();
    await expect(registerPage.confirmPassword).toBeFocused();
    await expect(registerPage.confirmPassword).toBeVisible();
  });
});
