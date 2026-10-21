import { type CheckoutData, validCheckout } from '../data/checkout';
import type { CartPage } from '../pages/cart.page';
import type { CheckoutPage } from '../pages/checkout.page';
import type { OrderSuccessPage } from '../pages/order-success.page';
import type { CartLine, ShoppingFlow } from './shopping.flow';

/** Cart → Checkout → Order success, reused by checkout, order-success and E2E tests. */
export class CheckoutFlow {
  constructor(
    private readonly shopping: ShoppingFlow,
    private readonly cart: CartPage,
    private readonly checkout: CheckoutPage,
    private readonly success: OrderSuccessPage,
  ) {}

  /** Fills the cart and opens the Checkout screen. */
  async openCheckoutWith(lines: CartLine[]): Promise<void> {
    await this.shopping.fillCart(lines);
    await this.cart.proceedToCheckout();
    await this.checkout.expectLoaded();
  }

  /** From the Checkout screen: fill the form, place the order and wait for the success screen. */
  async completeOrder(data: CheckoutData = validCheckout): Promise<void> {
    await this.checkout.fillForm(data);
    await this.checkout.placeOrder();
    await this.success.expectLoaded();
  }

  /** Whole path: cart → checkout → success. */
  async placeOrder(lines: CartLine[], data: CheckoutData = validCheckout): Promise<void> {
    await this.openCheckoutWith(lines);
    await this.completeOrder(data);
  }
}
