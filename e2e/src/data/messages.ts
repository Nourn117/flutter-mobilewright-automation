/** Texts shown by the app. Keep in sync with the Flutter validators and data sources. */
export const Messages = {
  auth: {
    invalidCredentials: 'Invalid email or password',
    accountLocked: 'This account is locked',
    emailAlreadyRegistered: 'Email already registered',
  },
  validation: {
    nameRequired: 'Name is required',
    nameTooShort: 'Name must be at least 3 characters',
    emailRequired: 'Email is required',
    emailInvalid: 'Enter a valid email',
    passwordRequired: 'Password is required',
    passwordTooShort: 'Password must be at least 8 characters',
    passwordNoUppercase: 'Password must contain an uppercase letter',
    passwordNoNumber: 'Password must contain a number',
    confirmRequired: 'Please confirm your password',
    passwordsMismatch: 'Passwords do not match',
    phoneRequired: 'Phone is required',
    phoneInvalid: 'Enter a valid Egyptian mobile number',
    cityRequired: 'Please select a city',
    addressRequired: 'Address is required',
    addressTooShort: 'Please enter the full address',
    dateRequired: 'Please select a delivery date',
  },
  products: {
    emptyTitle: 'No products found',
    emptyMessage: 'Try a different search term.',
  },
  cart: {
    emptyTitle: 'Your cart is empty',
    emptyMessage: 'Browse our products and add something you like.',
  },
  orderSuccess: {
    title: 'Order placed!',
  },
} as const;
