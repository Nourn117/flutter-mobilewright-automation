import { expect } from '@mobilewright/test';

import type { Product } from '../data/products';
import { TestIds } from '../data/test-ids';
import { formatPrice } from '../utils/format';
import { BasePage } from './base.page';

export class ProductDetailsPage extends BasePage {
  readonly name = this.byId(TestIds.detailsName);
  readonly price = this.byId(TestIds.detailsPrice);
  readonly quantity = this.byId(TestIds.detailsQuantity);
  readonly minus = this.byId(TestIds.detailsQtyMinus);
  readonly plus = this.byId(TestIds.detailsQtyPlus);
  readonly addToCartButton = this.byId(TestIds.detailsAddToCart);

  async expectProduct(product: Product): Promise<void> {
    await expect(this.name).toHaveText(product.name);
    await expect(this.price).toHaveText(formatPrice(product.price));
    await this.expectMessage(product.category);
  }

  async increase(times = 1): Promise<void> {
    for (let i = 0; i < times; i++) await this.tap(this.plus);
  }

  async decrease(times = 1): Promise<void> {
    for (let i = 0; i < times; i++) await this.tap(this.minus);
  }

  /** Quantity starts at 1, so this taps "+" (quantity - 1) times. */
  async setQuantity(quantity: number): Promise<void> {
    await this.increase(quantity - 1);
    await this.expectQuantity(quantity);
  }

  async expectQuantity(quantity: number): Promise<void> {
    await expect(this.quantity).toHaveText(String(quantity));
  }

  async expectAddButtonTotal(total: number): Promise<void> {
    // The id sits on a wrapper; the button text is on its child node.
    await expect(this.addToCartButton.getByText(formatPrice(total), { exact: false })).toBeVisible();
  }

  async addToCart(): Promise<void> {
    await this.addToCartButton.tap();
  }
}
