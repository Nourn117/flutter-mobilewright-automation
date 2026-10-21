import { Messages } from '../src/data/messages';
import { newUser, users } from '../src/data/users';
import { expect, test } from '../src/fixtures/test';
import type { RegisterForm } from '../src/pages/register.page';

/**
 * Register – docs/test-cases/register.md
 * Every test starts on the Register screen.
 */
test.describe('Register', () => {
  test.beforeEach(async ({ loginPage, registerPage }) => {
    await loginPage.expectLoaded();
    await loginPage.goToRegister();
    await registerPage.expectLoaded();
  });

  /** Valid form with a unique email; override only what the test is about. */
  const validForm = (overrides: Partial<RegisterForm> = {}): RegisterForm => {
    const user = newUser();
    return { name: user.name, email: user.email, password: user.password, ...overrides };
  };

  test('TC-REG-001 · register a new account', { tag: '@P1' }, async ({ registerPage }) => {
    const form = validForm();
    await registerPage.register(form);
    await registerPage.expectSuccessDialog(form.email);
  });

  test('TC-REG-002 · success dialog returns to Login with email pre-filled', { tag: '@P1' }, async ({ registerPage, loginPage }) => {
    const form = validForm();
    await registerPage.register(form);
    await registerPage.expectSuccessDialog(form.email);
    await registerPage.confirmSuccess();

    await loginPage.expectLoaded();
    await loginPage.expectEmail(form.email);
    await expect(loginPage.password).toHaveText('');
  });

  test('TC-REG-003 · log in with the newly registered account', { tag: '@P1' }, async ({
    registerPage,
    loginPage,
    homePage,
    productsPage,
    profilePage,
  }) => {
    const user = newUser({ name: 'Nouran Test' });
    await registerPage.registerUser(user);
    await registerPage.confirmSuccess();

    await loginPage.fillPassword(user.password);
    await loginPage.submit();
    await homePage.expectLoaded();
    await productsPage.expectGreeting('Nouran');

    await homePage.openProfile();
    await profilePage.expectUser(user);
  });

  test('TC-REG-004 · register with an already registered email', { tag: '@P1' }, async ({ registerPage }) => {
    await registerPage.register(validForm({ email: users.standard.email }));
    await registerPage.expectError(Messages.auth.emailAlreadyRegistered);
    await registerPage.expectNoSuccessDialog();
  });

  test('TC-REG-005 · submit with all fields empty', { tag: '@P1' }, async ({ registerPage }) => {
    await registerPage.submit();
    await registerPage.expectMessage(Messages.validation.nameRequired);
    await registerPage.expectMessage(Messages.validation.emailRequired);
    await registerPage.expectMessage(Messages.validation.passwordRequired);
    await registerPage.expectMessage(Messages.validation.confirmRequired);
    await registerPage.expectNoSuccessDialog();
  });

  test('TC-REG-006 · name shorter than 3 characters', { tag: '@P2' }, async ({ registerPage }) => {
    await registerPage.register(validForm({ name: 'Ab' }));
    await registerPage.expectMessage(Messages.validation.nameTooShort);
    await registerPage.expectNoSuccessDialog();
  });

  test('TC-REG-007 · name with spaces only', { tag: '@P3' }, async ({ registerPage }) => {
    await registerPage.register(validForm({ name: '   ' }));
    await registerPage.expectMessage(Messages.validation.nameRequired);
  });

  test('TC-REG-008 · name boundary – exactly 3 characters', { tag: '@P3' }, async ({ registerPage }) => {
    const form = validForm({ name: 'Ali' });
    await registerPage.register(form);
    await registerPage.expectSuccessDialog(form.email);
  });

  test('TC-REG-009 · invalid email format', { tag: '@P2' }, async ({ registerPage }) => {
    await registerPage.register(validForm({ email: 'user@demo' }));
    await registerPage.expectMessage(Messages.validation.emailInvalid);
    await registerPage.expectNoSuccessDialog();
  });

  test('TC-REG-010 · password length boundary (7 vs 8 characters)', { tag: '@P2' }, async ({ registerPage }) => {
    const form = validForm({ password: 'Abcde12' });
    await registerPage.register(form);
    await registerPage.expectMessage(Messages.validation.passwordTooShort);

    await registerPage.register({ ...form, password: 'Abcdef12' });
    await registerPage.expectSuccessDialog(form.email);
  });

  test('TC-REG-011 · password without an uppercase letter', { tag: '@P2' }, async ({ registerPage }) => {
    await registerPage.register(validForm({ password: 'test@1234' }));
    await registerPage.expectMessage(Messages.validation.passwordNoUppercase);
  });

  test('TC-REG-012 · password without a number', { tag: '@P2' }, async ({ registerPage }) => {
    await registerPage.register(validForm({ password: 'Test@abcd' }));
    await registerPage.expectMessage(Messages.validation.passwordNoNumber);
  });

  test('TC-REG-013 · password without a special character is accepted', { tag: '@P3' }, async ({ registerPage }) => {
    const form = validForm({ password: 'Test1234' });
    await registerPage.register(form);
    await registerPage.expectSuccessDialog(form.email);
  });

  test('TC-REG-014 · confirm password does not match', { tag: '@P1' }, async ({ registerPage }) => {
    await registerPage.register(validForm({ password: 'Test@1234', confirmPassword: 'Test@12345' }));
    await registerPage.expectMessage(Messages.validation.passwordsMismatch);
    await registerPage.expectNoSuccessDialog();
  });

  test.fixme('TC-REG-015 · password fields are masked', { tag: '@P3' }, async () => {
    // Masking is a visual check (the accessibility tree doesn't expose it). Covered manually.
  });

  test('TC-REG-016 · success dialog cannot be dismissed by tapping outside', { tag: '@P3' }, async ({ registerPage }) => {
    const form = validForm();
    await registerPage.register(form);
    await registerPage.expectSuccessDialog(form.email);
    await registerPage.tapOutsideDialog();
    await expect(registerPage.successDialog).toBeVisible();
  });

  test('TC-REG-017 · back from Register without submitting', { tag: '@P3' }, async ({ registerPage, loginPage }) => {
    await registerPage.fillForm(validForm());
    await registerPage.pressBack();
    await loginPage.expectLoaded();
    await loginPage.expectEmail('');
  });

  test('TC-REG-018 · name and email are trimmed', { tag: '@P3' }, async ({ registerPage, loginPage, homePage }) => {
    const email = newUser().email;
    await registerPage.register({ name: '  Sara Ali  ', email: `  ${email}  `, password: 'Test@1234' });
    await registerPage.expectSuccessDialog(email);
    await registerPage.confirmSuccess();

    await loginPage.expectEmail(email);
    await loginPage.fillPassword('Test@1234');
    await loginPage.submit();
    await homePage.expectLoaded();
  });
});
