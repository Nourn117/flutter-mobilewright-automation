export const DELIVERY_FEE = 50;

export const cities = ['Cairo', 'Giza', 'Alexandria', 'Mansoura', 'Tanta', 'Aswan'] as const;
export type City = (typeof cities)[number];

export type DeliverySlot = 'morning' | 'evening';
export type PaymentMethod = 'cash' | 'card';

export const slotLabels: Record<DeliverySlot, string> = {
  morning: '9 AM - 1 PM',
  evening: '5 PM - 9 PM',
};

export const paymentLabels: Record<PaymentMethod, string> = {
  cash: 'Cash on delivery',
  card: 'Card on delivery',
};

export interface CheckoutData {
  /** Leave undefined to keep the name pre-filled from the logged-in user. */
  fullName?: string;
  phone: string;
  city: City;
  address: string;
  slot?: DeliverySlot;
  payment?: PaymentMethod;
  notes?: string;
  saveAddress?: boolean;
}

export const validCheckout: CheckoutData = {
  phone: '01012345678',
  city: 'Cairo',
  address: '12 Tahrir Street, Downtown',
};
