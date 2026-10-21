import { Messages } from '../src/data/messages';
import { users } from '../src/data/users';
import { expect, test } from '../src/fixtures/test';

/**
 * Login – docs/test-cases/login.md
 * Tags: @P1 = smoke, @P2 = regression, @P3 = full.
 */
test.describe('Login', () => {
  test.beforeEach(async ({ loginPage }) => {
    await loginPage.expectLoaded();
  });

  test('TC-LOGIN-001 · login with valid credentials', { tag: '@P1' }, async ({ loginPage, homePage, productsPage }) => {
    await loginPage.loginAs(users.standard);
    await homePage.expectLoaded();
    await productsPage.expectLoaded();
    await productsPage.expectGreeting('Test');
  });

  test.fixme('TC-LOGIN-002 · login button is disabled while loading', { tag: '@P2' }, async () => {
    // The mock login takes 800 ms, which is shorter than one screen read on the
    // emulator, so the loading state can't be caught reliably. Covered manually.
  });

  test('TC-LOGIN-003 · wrong password', { tag: '@P1' }, async ({ loginPage, homePage }) => {
    await loginPage.login(users.standard.email, 'Wrong@123');
    await loginPage.expectError(Messages.auth.invalidCredentials);
    await loginPage.expectEmail(users.standard.email);
    await expect(homePage.shopTab).toBeHidden();
  });

  test('TC-LOGIN-004 · unregistered email', { tag: '@P1' }, async ({ loginPage }) => {
    await loginPage.login('nobody@demo.com', 'Test@1234');
    await loginPage.expectError(Messages.auth.invalidCredentials);
  });

  test('TC-LOGIN-005 · locked account', { tag: '@P1' }, async ({ loginPage, homePage }) => {
    await loginPage.loginAs(users.locked);
    await loginPage.expectError(Messages.auth.accountLocked);
    await expect(homePage.shopTab).toBeHidden();
  });

  test('TC-LOGIN-006 · submit with all fields empty', { tag: '@P1' }, async ({ loginPage }) => {
    await loginPage.submit();
    await loginPage.expectMessage(Messages.validation.emailRequired);
    await loginPage.expectMessage(Messages.validation.passwordRequired);
    await loginPage.expectNoError();
  });

  test('TC-LOGIN-007 · submit with empty email only', { tag: '@P2' }, async ({ loginPage }) => {
    await loginPage.fillPassword('Test@1234');
    await loginPage.submit();
    await loginPage.expectMessage(Messages.validation.emailRequired);
    await loginPage.expectNoMessage(Messages.validation.passwordRequired);
  });

  test('TC-LOGIN-008 · submit with empty password only', { tag: '@P2' }, async ({ loginPage }) => {
    await loginPage.fillEmail(users.standard.email);
    await loginPage.submit();
    await loginPage.expectMessage(Messages.validation.passwordRequired);
    await loginPage.expectNoMessage(Messages.validation.emailRequired);
  });

  for (const email of ['test@demo', 'testdemo.com', 'test @demo.com', '@demo.com']) {
    test(`TC-LOGIN-009 · invalid email format "${email}"`, { tag: '@P2' }, async ({ loginPage }) => {
      await loginPage.login(email, 'Test@1234');
      await loginPage.expectMessage(Messages.validation.emailInvalid);
      await loginPage.expectNoError();
    });
  }

  test('TC-LOGIN-010 · email with leading/trailing spaces is trimmed', { tag: '@P3' }, async ({ loginPage, homePage }) => {
    await loginPage.login(`  ${users.standard.email}  `, users.standard.password);
    await homePage.expectLoaded();
  });

  test('TC-LOGIN-011 · email is case-sensitive (OBS-01)', { tag: '@P3' }, async ({ loginPage }) => {
    await loginPage.login('TEST@demo.com', users.standard.password);
    await loginPage.expectError(Messages.auth.invalidCredentials);
  });

  test('TC-LOGIN-012 · password is case-sensitive', { tag: '@P2' }, async ({ loginPage }) => {
    await loginPage.login(users.standard.email, 'test@1234');
    await loginPage.expectError(Messages.auth.invalidCredentials);
  });

  test('TC-LOGIN-013 · show / hide password toggle', { tag: '@P2' }, async ({ loginPage }) => {
    await loginPage.fillPassword('Test@1234');
    await loginPage.expectPasswordToggle('Show password');
    await loginPage.togglePasswordVisibility();
    await loginPage.expectPasswordToggle('Hide password');
    await loginPage.togglePasswordVisibility();
    await loginPage.expectPasswordToggle('Show password');
  });

  test('TC-LOGIN-014 · submit from the keyboard action key', { tag: '@P3' }, async ({ loginPage, homePage }) => {
    await loginPage.loginWithKeyboard(users.standard.email, users.standard.password);
    await homePage.expectLoaded();
  });

  test('TC-LOGIN-015 · recover after a failed attempt', { tag: '@P2' }, async ({ loginPage, homePage }) => {
    await loginPage.login(users.standard.email, 'Wrong@123');
    await loginPage.expectError(Messages.auth.invalidCredentials);
    await loginPage.fillPassword(users.standard.password);
    await loginPage.submit();
    await homePage.expectLoaded();
  });

  test('TC-LOGIN-016 · navigate to Register', { tag: '@P2' }, async ({ loginPage, registerPage }) => {
    await loginPage.goToRegister();
    await registerPage.expectLoaded();
  });

  test('TC-LOGIN-017 · back after login does not return to Login', { tag: '@P2' }, async ({ loginPage, homePage }) => {
    await loginPage.loginAs(users.standard);
    await homePage.expectLoaded();
    await homePage.pressBack();
    await expect(homePage.shopTab).toBeHidden();
    await expect(loginPage.title).toBeHidden();
  });

  test('TC-LOGIN-018 · login screen UI elements', { tag: '@P3' }, async ({ loginPage }) => {
    await expect(loginPage.title).toBeVisible();
    await loginPage.expectMessage('Log in to continue shopping');
    await expect(loginPage.email).toBeVisible();
    await expect(loginPage.password).toBeVisible();
    await expect(loginPage.loginButton).toBeVisible();
    await loginPage.expectMessage("Don't have an account?");
    await expect(loginPage.registerLink).toBeVisible();
  });
});
