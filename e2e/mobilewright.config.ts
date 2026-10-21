import { defineConfig } from 'mobilewright';

export default defineConfig({
  testDir: './tests',
  platform: 'android',
  bundleId: 'com.nouran.mobilewright_demo_app',

  // One emulator → run tests one by one.
  workers: 1,
  fullyParallel: false,

  // Retry once locally (emulator hiccups), twice on CI.
  retries: process.env.CI ? 2 : 1,

  timeout: 120_000,
  expect: { timeout: 10_000 },
  use: {
    actionTimeout: 10_000,
    animations: 'off',
  },

  // Attach the screen's element tree to every failed test (easier debugging).
  viewTree: 'on-failure',

  reporter: [
    ['list'],
    ['html', { open: 'never' }],
    ['junit', { outputFile: 'test-results/junit.xml' }],
  ],
});