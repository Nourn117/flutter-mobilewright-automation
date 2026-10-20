import { expect } from '@mobilewright/test';

import type { Product } from '../data/products';
import { TestIds } from '../data/test-ids';
import { BasePage } from './base.page';

/** Bottom sheet shown after "Add to cart" on the details screen. */
export class AddedToCartSheet extends BasePage {
  readonly sheet = this.byId(TestIds.addedSheet);
  readonly keepShoppingButton = this.byId(TestIds.addedSheetContinue);
  readonly goToCartButton = this.byId(TestIds.addedSheetGoToCart);

  async expectShown(product: Product, quantity: number): Promise<void> {
    await expect(this.sheet).toBeVisible();
    await this.expectMessage('Added to cart');
    await this.expectMessage(`${quantity} × ${product.name}`);
  }

  async keepShopping(): Promise<void> {
    await this.keepShoppingButton.tap();
  }

  async goToCart(): Promise<void> {
    await this.goToCartButton.tap();
  }

  /** Closes the sheet without choosing an option (swipe it down). */
  async dismiss(): Promise<void> {
    await this.sheet.swipe({ direction: 'down' });
    await expect(this.sheet).toBeHidden();
  }
}
