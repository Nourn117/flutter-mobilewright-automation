import { expect } from '@mobilewright/test';

import { TestIds } from '../data/test-ids';
import type { User } from '../data/users';
import { APP_START_TIMEOUT, BasePage } from './base.page';

export class LoginPage extends BasePage {
  readonly title = this.byText('Welcome back');
  readonly email = this.byId(TestIds.loginEmail);
  readonly password = this.byId(TestIds.loginPassword);
  readonly passwordToggle = this.byId(TestIds.loginPasswordToggle);
  readonly loginButton = this.byId(TestIds.loginButton);
  readonly error = this.byId(TestIds.loginError);
  readonly registerLink = this.byId(TestIds.loginGoToRegister);

  protected override keyboardDismissArea() {
    return this.title;
  }

  async expectLoaded(): Promise<void> {
    await expect(this.title).toBeVisible({ timeout: APP_START_TIMEOUT });
    await expect(this.loginButton).toBeVisible();
  }

  /** Taps "Log in" without filling anything (or after filling some fields). */
  async submit(): Promise<void> {
    await this.tap(this.loginButton);
  }

  async fillEmail(email: string): Promise<void> {
    await this.fill(this.email, email);
  }

  async fillPassword(password: string): Promise<void> {
    await this.fill(this.password, password);
  }

  /** Types the password and submits with the keyboard action key instead of the button. */
  async loginWithKeyboard(email: string, password: string): Promise<void> {
    await this.fillEmail(email);
    await this.password.tap();
    await expect(this.password).toBeFocused();
    await this.password.fill(password);
    await this.screen.pressButton('ENTER');
  }

  async login(email: string, password: string): Promise<void> {
    await this.fill(this.email, email);
    await this.fill(this.password, password);
    await this.tap(this.loginButton);
  }

  async loginAs(user: User): Promise<void> {
    await this.login(user.email, user.password);
  }

  async togglePasswordVisibility(): Promise<void> {
    await this.tap(this.passwordToggle);
  }

  async goToRegister(): Promise<void> {
    await this.tap(this.registerLink);
  }

  async expectError(message: string): Promise<void> {
    await expect(this.error).toHaveText(message);
  }

  async expectEmail(value: string): Promise<void> {
    await expect(this.email).toHaveText(value);
  }

  /** The toggle's tooltip says what tapping it will do: "Show password" or "Hide password". */
  async expectPasswordToggle(label: 'Show password' | 'Hide password'): Promise<void> {
    await expect(this.passwordToggle.getByText(label)).toBeVisible();
  }

  async expectNoError(): Promise<void> {
    await expect(this.error).toBeHidden();
  }
}
