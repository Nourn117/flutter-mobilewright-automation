import { defineConfig } from 'mobilewright';

export default defineConfig({
  testDir: "./tests",
  platform: "android",
  bundleId: "com.nouran.mobilewright_demo_app",
  reporter: [['html', { open: 'never' }]],
});
