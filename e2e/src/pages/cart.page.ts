import { expect } from '@mobilewright/test';

import { DELIVERY_FEE } from '../data/checkout';
import { Messages } from '../data/messages';
import type { Product } from '../data/products';
import { TestIds } from '../data/test-ids';
import { formatPrice } from '../utils/format';
import { BasePage } from './base.page';

export class CartPage extends BasePage {
  readonly title = this.byText('My Cart');
  readonly empty = this.byId(TestIds.cartEmpty);
  readonly startShoppingButton = this.byId(TestIds.cartStartShopping);
  readonly subtotal = this.byId(TestIds.cartSubtotal);
  readonly deliveryFee = this.byId(TestIds.cartDeliveryFee);
  readonly total = this.byId(TestIds.cartTotal);
  readonly checkoutButton = this.byId(TestIds.cartCheckout);

  item(product: Product) {
    return this.byId(TestIds.cartItem(product.id));
  }

  async expectEmpty(): Promise<void> {
    await expect(this.empty).toBeVisible();
    await this.expectMessage(Messages.cart.emptyTitle);
    await this.expectMessage(Messages.cart.emptyMessage);
  }

  minusButton(product: Product) {
    return this.byId(TestIds.cartItemMinus(product.id)).getByText('Decrease quantity');
  }

  plusButton(product: Product) {
    return this.byId(TestIds.cartItemPlus(product.id)).getByText('Increase quantity');
  }

  /** Exact subtotal label, e.g. "Subtotal (3 items)". */
  async expectSubtotalLabel(label: string): Promise<void> {
    await expect(this.byText(label)).toBeVisible();
  }

  async startShopping(): Promise<void> {
    await this.startShoppingButton.tap();
  }

  async increase(product: Product, times = 1): Promise<void> {
    const plus = this.byId(TestIds.cartItemPlus(product.id));
    for (let i = 0; i < times; i++) await this.tap(plus);
  }

  async decrease(product: Product, times = 1): Promise<void> {
    const minus = this.byId(TestIds.cartItemMinus(product.id));
    for (let i = 0; i < times; i++) await this.tap(minus);
  }

  async remove(product: Product): Promise<void> {
    await this.tap(this.byId(TestIds.cartRemove(product.id)));
  }

  /** Row exists with the right quantity and line total. */
  async expectItem(product: Product, quantity: number): Promise<void> {
    await this.reveal(this.item(product));
    await expect(this.byId(TestIds.cartItemQuantity(product.id))).toHaveText(String(quantity));
    await expect(this.byId(TestIds.cartItemTotal(product.id))).toHaveText(
      formatPrice(product.price * quantity),
    );
  }

  async expectNoItem(product: Product): Promise<void> {
    await expect(this.item(product)).toHaveCount(0);
  }

  /** Checks subtotal, delivery fee and total for a given subtotal. */
  async expectTotals(subtotal: number): Promise<void> {
    await expect(this.subtotal).toHaveText(formatPrice(subtotal));
    await expect(this.deliveryFee).toHaveText(formatPrice(DELIVERY_FEE));
    await expect(this.total).toHaveText(formatPrice(subtotal + DELIVERY_FEE));
  }

  async proceedToCheckout(): Promise<void> {
    await this.checkoutButton.tap();
  }
}
