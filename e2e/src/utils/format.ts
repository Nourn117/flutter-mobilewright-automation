/** Same formatting as `lib/core/utils/format.dart`: 2499 -> "EGP 2,499", 45.5 -> "EGP 45.50". */
export function formatPrice(value: number): string {
  const whole = Math.trunc(Math.abs(value));
  const grouped = whole.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  const piasters = Math.round((Math.abs(value) - whole) * 100);
  const fraction = piasters === 0 ? '' : `.${piasters.toString().padStart(2, '0')}`;
  return `EGP ${value < 0 ? '-' : ''}${grouped}${fraction}`;
}

/** Sum of price × quantity for a list of cart lines. */
export function subtotalOf(lines: ReadonlyArray<{ price: number; quantity: number }>): number {
  return lines.reduce((sum, line) => sum + line.price * line.quantity, 0);
}
