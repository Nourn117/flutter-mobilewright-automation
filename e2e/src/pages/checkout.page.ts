import { expect } from '@mobilewright/test';

import { type CheckoutData, type City, type DeliverySlot, type PaymentMethod } from '../data/checkout';
import { TestIds } from '../data/test-ids';
import { formatPrice } from '../utils/format';
import { BasePage } from './base.page';

export class CheckoutPage extends BasePage {
  readonly title = this.byText('Checkout');
  readonly fullName = this.byId(TestIds.checkoutName);
  readonly phone = this.byId(TestIds.checkoutPhone);
  readonly city = this.byId(TestIds.checkoutCity);
  readonly address = this.byId(TestIds.checkoutAddress);
  readonly deliveryDate = this.byId(TestIds.checkoutDate);
  readonly morningSlot = this.byId(TestIds.checkoutSlotMorning);
  readonly eveningSlot = this.byId(TestIds.checkoutSlotEvening);
  readonly cashPayment = this.byId(TestIds.checkoutPaymentCash);
  readonly cardPayment = this.byId(TestIds.checkoutPaymentCard);
  readonly notes = this.byId(TestIds.checkoutNotes);
  readonly saveAddress = this.byId(TestIds.checkoutSaveAddress);
  readonly total = this.byId(TestIds.checkoutTotal);
  readonly error = this.byId(TestIds.checkoutError);
  readonly placeOrderButton = this.byId(TestIds.checkoutPlaceOrder);

  protected override keyboardDismissArea() {
    return this.title;
  }

  async expectLoaded(): Promise<void> {
    await expect(this.title).toBeVisible();
    await expect(this.fullName).toBeVisible();
  }

  async fillFullName(name: string): Promise<void> {
    await this.fill(this.fullName, name, 'down');
  }

  async fillPhone(phone: string): Promise<void> {
    await this.fill(this.phone, phone);
  }

  async selectCity(city: City): Promise<void> {
    await this.tap(this.city);
    await this.byText(city).last().tap();
  }

  async fillAddress(address: string): Promise<void> {
    await this.fill(this.address, address);
  }

  /** Opens the date picker and confirms the default date (tomorrow, the first allowed day). */
  async pickEarliestDeliveryDate(): Promise<void> {
    await this.tap(this.deliveryDate);
    await this.byText('OK').tap();
  }

  async selectSlot(slot: DeliverySlot): Promise<void> {
    await this.tap(slot === 'morning' ? this.morningSlot : this.eveningSlot);
  }

  async selectPayment(method: PaymentMethod): Promise<void> {
    await this.tap(method === 'cash' ? this.cashPayment : this.cardPayment);
  }

  async fillNotes(notes: string): Promise<void> {
    await this.fill(this.notes, notes);
  }

  async setSaveAddress(checked: boolean): Promise<void> {
    await this.reveal(this.saveAddress);
    await this.saveAddress.setChecked(checked);
  }

  /** Fills every field from `data`, top to bottom. */
  async fillForm(data: CheckoutData): Promise<void> {
    if (data.fullName !== undefined) await this.fillFullName(data.fullName);
    await this.fillPhone(data.phone);
    await this.selectCity(data.city);
    await this.fillAddress(data.address);
    await this.pickEarliestDeliveryDate();
    if (data.slot) await this.selectSlot(data.slot);
    if (data.payment) await this.selectPayment(data.payment);
    if (data.notes) await this.fillNotes(data.notes);
    if (data.saveAddress !== undefined) await this.setSaveAddress(data.saveAddress);
  }

  /** Taps "Place order" (keyboard is already closed after every fill). */
  async placeOrder(): Promise<void> {
    await this.placeOrderButton.tap();
  }

  async expectTotal(total: number): Promise<void> {
    await this.reveal(this.total);
    await expect(this.total).toHaveText(formatPrice(total));
    await expect(this.placeOrderButton.getByText(formatPrice(total), { exact: false })).toBeVisible();
  }
}
