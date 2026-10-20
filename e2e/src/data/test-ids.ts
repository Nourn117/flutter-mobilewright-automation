/**
 * Mirror of `lib/core/testing/test_ids.dart` in the Flutter app.
 * Flutter exposes them as Android resource-ids, so `screen.getByTestId(id)` finds them.
 * Keep both files in sync.
 */
export const TestIds = {
  // Login
  loginEmail: 'login_email',
  loginPassword: 'login_password',
  loginPasswordToggle: 'login_password_toggle',
  loginButton: 'login_button',
  loginError: 'login_error',
  loginGoToRegister: 'login_go_to_register',

  // Register
  registerName: 'register_name',
  registerEmail: 'register_email',
  registerPassword: 'register_password',
  registerConfirmPassword: 'register_confirm_password',
  registerButton: 'register_button',
  registerError: 'register_error',
  registerSuccessDialog: 'register_success_dialog',
  registerSuccessOk: 'register_success_ok',

  // Bottom navigation
  navProducts: 'nav_products',
  navCart: 'nav_cart',
  navProfile: 'nav_profile',
  cartBadge: 'cart_badge',

  // Products
  productsSearch: 'products_search',
  productsLoading: 'products_loading',
  productsError: 'products_error',
  productsRetry: 'products_retry',
  productsEmpty: 'products_empty',
  productItem: (id: string) => `product_item_${id}`,

  // Product details
  detailsName: 'details_name',
  detailsPrice: 'details_price',
  detailsQuantity: 'details_quantity',
  detailsQtyMinus: 'details_qty_minus',
  detailsQtyPlus: 'details_qty_plus',
  detailsAddToCart: 'details_add_to_cart',

  // Added-to-cart bottom sheet
  addedSheet: 'added_sheet',
  addedSheetContinue: 'added_sheet_continue',
  addedSheetGoToCart: 'added_sheet_go_to_cart',

  // Cart
  cartEmpty: 'cart_empty',
  cartStartShopping: 'cart_start_shopping',
  cartSubtotal: 'cart_subtotal',
  cartDeliveryFee: 'cart_delivery_fee',
  cartTotal: 'cart_total',
  cartCheckout: 'cart_checkout',
  cartItem: (id: string) => `cart_item_${id}`,
  cartItemQuantity: (id: string) => `cart_item_quantity_${id}`,
  cartItemPlus: (id: string) => `cart_item_plus_${id}`,
  cartItemMinus: (id: string) => `cart_item_minus_${id}`,
  cartItemTotal: (id: string) => `cart_item_total_${id}`,
  cartRemove: (id: string) => `cart_remove_${id}`,

  // Checkout
  checkoutName: 'checkout_name',
  checkoutPhone: 'checkout_phone',
  checkoutCity: 'checkout_city',
  checkoutAddress: 'checkout_address',
  checkoutDate: 'checkout_date',
  checkoutSlotMorning: 'checkout_slot_morning',
  checkoutSlotEvening: 'checkout_slot_evening',
  checkoutPaymentCash: 'checkout_payment_cash',
  checkoutPaymentCard: 'checkout_payment_card',
  checkoutSaveAddress: 'checkout_save_address',
  checkoutNotes: 'checkout_notes',
  checkoutTotal: 'checkout_total',
  checkoutError: 'checkout_error',
  checkoutPlaceOrder: 'checkout_place_order',

  // Order success
  orderSuccessTitle: 'order_success_title',
  orderNumber: 'order_number',
  orderTotal: 'order_total',
  orderBackHome: 'order_back_home',

  // Profile
  profileName: 'profile_name',
  profileEmail: 'profile_email',
  profileDarkMode: 'profile_dark_mode',
  profileLogout: 'profile_logout',
  profileConfirmLogout: 'profile_confirm_logout',
  profileCancelLogout: 'profile_cancel_logout',
} as const;
