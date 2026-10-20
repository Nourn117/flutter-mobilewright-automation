import { defineConfig } from 'mobilewright';

export default defineConfig({
  testDir: './tests',
  platform: 'android',
  bundleId: 'com.nouran.mobilewright_demo_app',

  // One emulator → run tests one by one.
  workers: 1,
  fullyParallel: false,

  // Flutter debug builds on an emulator are slower than release builds.
  timeout: 120_000,
  expect: { timeout: 10_000 },
  use: {
    actionTimeout: 10_000,
    animations: 'off',
  },

  reporter: [['list'], ['html', { open: 'never' }]],
});
