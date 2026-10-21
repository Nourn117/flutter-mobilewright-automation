import { test as base, expect } from '@mobilewright/test';

import { users } from '../data/users';
import { CheckoutFlow } from '../flows/checkout.flow';
import { ShoppingFlow } from '../flows/shopping.flow';
import { AddedToCartSheet } from '../pages/added-to-cart.sheet';
import { CartPage } from '../pages/cart.page';
import { CheckoutPage } from '../pages/checkout.page';
import { HomePage } from '../pages/home.page';
import { LoginPage } from '../pages/login.page';
import { OrderSuccessPage } from '../pages/order-success.page';
import { ProductDetailsPage } from '../pages/product-details.page';
import { ProductsPage } from '../pages/products.page';
import { ProfilePage } from '../pages/profile.page';
import { RegisterPage } from '../pages/register.page';

type Pages = {
  loginPage: LoginPage;
  registerPage: RegisterPage;
  homePage: HomePage;
  productsPage: ProductsPage;
  detailsPage: ProductDetailsPage;
  addedSheet: AddedToCartSheet;
  cartPage: CartPage;
  checkoutPage: CheckoutPage;
  orderSuccessPage: OrderSuccessPage;
  profilePage: ProfilePage;
};

type Flows = {
  shopping: ShoppingFlow;
  checkoutFlow: CheckoutFlow;
  /** Logs in as the standard user before the test and lands on the Shop tab. */
  loggedIn: HomePage;
};

/**
 * Project test object: every test imports `test` and `expect` from here.
 * The app is relaunched before each test (Mobilewright default), so every
 * test starts on the Login screen with fresh in-memory data.
 */
export const test = base.extend<Pages & Flows>({
  loginPage: async ({ screen }, use) => use(new LoginPage(screen)),
  registerPage: async ({ screen }, use) => use(new RegisterPage(screen)),
  homePage: async ({ screen }, use) => use(new HomePage(screen)),
  productsPage: async ({ screen }, use) => use(new ProductsPage(screen)),
  detailsPage: async ({ screen }, use) => use(new ProductDetailsPage(screen)),
  addedSheet: async ({ screen }, use) => use(new AddedToCartSheet(screen)),
  cartPage: async ({ screen }, use) => use(new CartPage(screen)),
  checkoutPage: async ({ screen }, use) => use(new CheckoutPage(screen)),
  orderSuccessPage: async ({ screen }, use) => use(new OrderSuccessPage(screen)),
  profilePage: async ({ screen }, use) => use(new ProfilePage(screen)),

  shopping: async ({ homePage, productsPage, detailsPage, addedSheet }, use) =>
    use(new ShoppingFlow(homePage, productsPage, detailsPage, addedSheet)),

  checkoutFlow: async ({ shopping, cartPage, checkoutPage, orderSuccessPage }, use) =>
    use(new CheckoutFlow(shopping, cartPage, checkoutPage, orderSuccessPage)),

  loggedIn: async ({ loginPage, homePage, productsPage }, use) => {
    await loginPage.expectLoaded();
    await loginPage.loginAs(users.standard);
    await homePage.expectLoaded();
    await productsPage.expectLoaded();
    await use(homePage);
  },
});

export { expect };
