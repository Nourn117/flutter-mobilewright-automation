/// Every test identifier in one place.
/// Keep these in sync with the Mobilewright page objects.
class TestIds {
  TestIds._();

  // Login
  static const loginEmail = 'login_email';
  static const loginPassword = 'login_password';
  static const loginPasswordToggle = 'login_password_toggle';
  static const loginButton = 'login_button';
  static const loginError = 'login_error';
  static const loginGoToRegister = 'login_go_to_register';

  // Register
  static const registerName = 'register_name';
  static const registerEmail = 'register_email';
  static const registerPassword = 'register_password';
  static const registerConfirmPassword = 'register_confirm_password';
  static const registerButton = 'register_button';
  static const registerError = 'register_error';
  static const registerSuccessDialog = 'register_success_dialog';
  static const registerSuccessOk = 'register_success_ok';

  // Bottom navigation
  static const navProducts = 'nav_products';
  static const navCart = 'nav_cart';
  static const navProfile = 'nav_profile';
  static const cartBadge = 'cart_badge';

  // Products
  static const productsSearch = 'products_search';
  static const productsLoading = 'products_loading';
  static const productsError = 'products_error';
  static const productsRetry = 'products_retry';
  static const productsEmpty = 'products_empty';
  static String productItem(String id) => 'product_item_$id';

  // Product details
  static const detailsName = 'details_name';
  static const detailsPrice = 'details_price';
  static const detailsQuantity = 'details_quantity';
  static const detailsQtyMinus = 'details_qty_minus';
  static const detailsQtyPlus = 'details_qty_plus';
  static const detailsAddToCart = 'details_add_to_cart';

  // Added-to-cart bottom sheet
  static const addedSheet = 'added_sheet';
  static const addedSheetContinue = 'added_sheet_continue';
  static const addedSheetGoToCart = 'added_sheet_go_to_cart';

  // Cart
  static const cartEmpty = 'cart_empty';
  static const cartStartShopping = 'cart_start_shopping';
  static const cartSubtotal = 'cart_subtotal';
  static const cartDeliveryFee = 'cart_delivery_fee';
  static const cartTotal = 'cart_total';
  static const cartCheckout = 'cart_checkout';
  static String cartItem(String id) => 'cart_item_$id';
  static String cartItemQuantity(String id) => 'cart_item_quantity_$id';
  static String cartItemPlus(String id) => 'cart_item_plus_$id';
  static String cartItemMinus(String id) => 'cart_item_minus_$id';
  static String cartItemTotal(String id) => 'cart_item_total_$id';
  static String cartRemove(String id) => 'cart_remove_$id';

  // Checkout
  static const checkoutName = 'checkout_name';
  static const checkoutPhone = 'checkout_phone';
  static const checkoutCity = 'checkout_city';
  static const checkoutAddress = 'checkout_address';
  static const checkoutDate = 'checkout_date';
  static const checkoutSlotMorning = 'checkout_slot_morning';
  static const checkoutSlotEvening = 'checkout_slot_evening';
  static const checkoutPaymentCash = 'checkout_payment_cash';
  static const checkoutPaymentCard = 'checkout_payment_card';
  static const checkoutSaveAddress = 'checkout_save_address';
  static const checkoutNotes = 'checkout_notes';
  static const checkoutTotal = 'checkout_total';
  static const checkoutError = 'checkout_error';
  static const checkoutPlaceOrder = 'checkout_place_order';

  // Order success
  static const orderSuccessTitle = 'order_success_title';
  static const orderNumber = 'order_number';
  static const orderTotal = 'order_total';
  static const orderBackHome = 'order_back_home';

  // Profile
  static const profileName = 'profile_name';
  static const profileEmail = 'profile_email';
  static const profileDarkMode = 'profile_dark_mode';
  static const profileLogout = 'profile_logout';
  static const profileConfirmLogout = 'profile_confirm_logout';
  static const profileCancelLogout = 'profile_cancel_logout';
}
