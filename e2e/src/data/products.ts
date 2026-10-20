export interface Product {
  id: string;
  name: string;
  category: 'Audio' | 'Wearables' | 'Accessories';
  /** Price in EGP. */
  price: number;
}

/** Catalogue served by the app's mock data source. */
export const products = {
  headphones: { id: 'p1', name: 'Wireless Headphones', category: 'Audio', price: 2499 },
  smartWatch: { id: 'p2', name: 'Smart Watch', category: 'Wearables', price: 5999 },
  speaker: { id: 'p3', name: 'Bluetooth Speaker', category: 'Audio', price: 1299 },
  laptopStand: { id: 'p4', name: 'Laptop Stand', category: 'Accessories', price: 899 },
  usbHub: { id: 'p5', name: 'USB-C Hub', category: 'Accessories', price: 749 },
  keyboard: { id: 'p6', name: 'Mechanical Keyboard', category: 'Accessories', price: 2199 },
  fitnessBand: { id: 'p7', name: 'Fitness Band', category: 'Wearables', price: 1499 },
  earbuds: { id: 'p8', name: 'Wireless Earbuds', category: 'Audio', price: 1899 },
} as const satisfies Record<string, Product>;

export const allProducts: readonly Product[] = Object.values(products);

export const MAX_QUANTITY = 10;
