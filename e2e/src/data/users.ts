export interface User {
  name: string;
  email: string;
  password: string;
}

/** Accounts that exist in the app's mock data source. */
export const users = {
  standard: { name: 'Test User', email: 'test@demo.com', password: 'Test@1234' },
  locked: { name: 'Locked User', email: 'locked@demo.com', password: 'Test@1234' },
} as const satisfies Record<string, User>;

/** A brand-new user with a unique email (the app resets on every launch, but unique is safer). */
export function newUser(overrides: Partial<User> = {}): User {
  return {
    name: 'Nouran Test',
    email: `user.${Date.now()}@demo.com`,
    password: 'Test@1234',
    ...overrides,
  };
}
