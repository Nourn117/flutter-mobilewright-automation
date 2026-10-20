import { expect } from '@mobilewright/test';

import { Messages } from '../data/messages';
import type { Product } from '../data/products';
import { TestIds } from '../data/test-ids';
import { formatPrice } from '../utils/format';
import { BasePage } from './base.page';

export class ProductsPage extends BasePage {
  readonly heading = this.byText('Find your next gadget');
  readonly search = this.byId(TestIds.productsSearch);
  readonly loading = this.byId(TestIds.productsLoading);
  readonly empty = this.byId(TestIds.productsEmpty);

  protected override keyboardDismissArea() {
    return this.heading;
  }

  card(product: Product) {
    return this.byId(TestIds.productItem(product.id));
  }

  async expectLoaded(): Promise<void> {
    await expect(this.heading).toBeVisible();
    await expect(this.loading).toBeHidden();
  }

  async expectGreeting(firstName: string): Promise<void> {
    await this.expectMessage(`Hello, ${firstName}`);
  }

  async searchFor(text: string): Promise<void> {
    await this.fill(this.search, text, 'down');
  }

  async clearSearch(): Promise<void> {
    await this.search.clear();
  }

  async openProduct(product: Product): Promise<void> {
    await this.tap(this.card(product));
  }

  /**
   * Card is present and shows the right name, category and price.
   * Flutter merges the card texts into one child node: "Name\nCategory\nEGP x".
   */
  async expectProduct(product: Product): Promise<void> {
    const card = this.card(product);
    await this.reveal(card);
    const label = `${product.name}\n${product.category}\n${formatPrice(product.price)}`;
    await expect(card.getByText(label)).toBeVisible();
  }

  async expectProductNotListed(product: Product): Promise<void> {
    await expect(this.card(product)).toHaveCount(0);
  }

  async expectNoResults(): Promise<void> {
    await expect(this.empty).toBeVisible();
    await this.expectMessage(Messages.products.emptyTitle);
    await this.expectMessage(Messages.products.emptyMessage);
  }
}
