import type { Product } from '../data/products';
import type { AddedToCartSheet } from '../pages/added-to-cart.sheet';
import type { HomePage } from '../pages/home.page';
import type { ProductDetailsPage } from '../pages/product-details.page';
import type { ProductsPage } from '../pages/products.page';

export interface CartLine {
  product: Product;
  quantity: number;
}

/** Multi-screen actions reused by many tests. */
export class ShoppingFlow {
  constructor(
    private readonly home: HomePage,
    private readonly products: ProductsPage,
    private readonly details: ProductDetailsPage,
    private readonly sheet: AddedToCartSheet,
  ) {}

  /**
   * From the Shop tab: open the product, set the quantity, add it and
   * choose what to do in the confirmation sheet.
   */
  async addToCart(
    product: Product,
    quantity = 1,
    then: 'keep-shopping' | 'go-to-cart' = 'keep-shopping',
  ): Promise<void> {
    await this.products.openProduct(product);
    await this.details.expectProduct(product);
    if (quantity > 1) await this.details.setQuantity(quantity);
    await this.details.addToCart();
    await this.sheet.expectShown(product, quantity);
    if (then === 'go-to-cart') {
      await this.sheet.goToCart();
    } else {
      await this.sheet.keepShopping();
    }
  }

  /** Adds several products, then opens the Cart tab. */
  async fillCart(lines: CartLine[]): Promise<void> {
    await this.home.openShop();
    for (const { product, quantity } of lines) {
      await this.addToCart(product, quantity, 'keep-shopping');
    }
    await this.home.openCart();
  }
}
