import { expect } from '@mobilewright/test';

import { TestIds } from '../data/test-ids';
import { BasePage } from './base.page';

/** Bottom navigation shown after login (Shop / Cart / Profile). */
export class HomePage extends BasePage {
  readonly shopTab = this.byId(TestIds.navProducts);
  readonly cartTab = this.byId(TestIds.navCart);
  readonly profileTab = this.byId(TestIds.navProfile);

  async expectLoaded(): Promise<void> {
    await expect(this.shopTab).toBeVisible();
    await expect(this.cartTab).toBeVisible();
    await expect(this.profileTab).toBeVisible();
  }

  async openShop(): Promise<void> {
    await this.shopTab.tap();
  }

  async openCart(): Promise<void> {
    await this.cartTab.tap();
  }

  async openProfile(): Promise<void> {
    await this.profileTab.tap();
  }

  /**
   * NavigationBar merges each tab into one node ("Cart\nTab 2 of 3"), so the badge
   * is read from the Cart tab text. The app labels the badge "Cart items: N".
   */
  async expectCartBadge(count: number): Promise<void> {
    if (count === 0) {
      await expect(this.cartTab).not.toContainText('Cart items:');
    } else {
      await expect(this.cartTab).toContainText(`Cart items: ${count}`);
    }
  }
}
