import { test, expect } from '@mobilewright/test';

test('login screen is visible on launch', async ({ screen }) => {
  await expect(screen.getByText('Welcome back')).toBeVisible();
  await expect(screen.getByTestId('login_email')).toBeVisible();
  await expect(screen.getByTestId('login_password')).toBeVisible();
  await expect(screen.getByTestId('login_button')).toBeVisible();
});