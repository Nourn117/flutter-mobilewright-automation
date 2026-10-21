import { expect } from '@mobilewright/test';

import { Messages } from '../data/messages';
import { TestIds } from '../data/test-ids';
import { formatPrice } from '../utils/format';
import { BasePage } from './base.page';

export class OrderSuccessPage extends BasePage {
  readonly title = this.byId(TestIds.orderSuccessTitle);
  readonly orderNumber = this.byId(TestIds.orderNumber);
  readonly total = this.byId(TestIds.orderTotal);
  readonly backHomeButton = this.byId(TestIds.orderBackHome);

  async expectLoaded(): Promise<void> {
    await expect(this.title).toHaveText(Messages.orderSuccess.title);
  }

  async expectOrderNumber(orderNumber: string): Promise<void> {
    await expect(this.orderNumber).toHaveText(orderNumber);
  }

  async expectTotal(total: number): Promise<void> {
    await this.reveal(this.total);
    await expect(this.total).toHaveText(formatPrice(total));
  }

  async expectSummary(summary: { slot: string; payment: string }): Promise<void> {
    await this.expectMessage(summary.slot);
    await this.expectMessage(summary.payment);
  }

  async backToShopping(): Promise<void> {
    await this.backHomeButton.tap();
  }
}
