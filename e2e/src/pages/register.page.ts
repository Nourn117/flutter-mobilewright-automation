import { expect } from '@mobilewright/test';

import { TestIds } from '../data/test-ids';
import type { User } from '../data/users';
import { BasePage } from './base.page';

export interface RegisterForm {
  name: string;
  email: string;
  password: string;
  /** Defaults to `password`. */
  confirmPassword?: string;
}

export class RegisterPage extends BasePage {
  readonly title = this.byText('Create account').first();
  readonly name = this.byId(TestIds.registerName);
  readonly email = this.byId(TestIds.registerEmail);
  readonly password = this.byId(TestIds.registerPassword);
  readonly confirmPassword = this.byId(TestIds.registerConfirmPassword);
  readonly submitButton = this.byId(TestIds.registerButton);
  readonly error = this.byId(TestIds.registerError);
  readonly successDialog = this.byId(TestIds.registerSuccessDialog);
  readonly successOk = this.byId(TestIds.registerSuccessOk);

  protected override keyboardDismissArea() {
    return this.byText('Join us and start shopping in seconds.');
  }

  async expectLoaded(): Promise<void> {
    await expect(this.name).toBeVisible();
    await expect(this.submitButton).toBeVisible();
  }

  async fillForm(form: RegisterForm): Promise<void> {
    await this.fill(this.name, form.name);
    await this.fill(this.email, form.email);
    await this.fill(this.password, form.password);
    await this.fill(this.confirmPassword, form.confirmPassword ?? form.password);
  }

  async submit(): Promise<void> {
    await this.tap(this.submitButton);
  }

  async register(form: RegisterForm): Promise<void> {
    await this.fillForm(form);
    await this.submit();
  }

  async registerUser(user: User): Promise<void> {
    await this.register({ name: user.name, email: user.email, password: user.password });
  }

  async expectSuccessDialog(email: string): Promise<void> {
    await expect(this.successDialog).toBeVisible();
    await this.expectMessage('Account created');
    await this.expectMessage(`You can now log in with ${email}.`);
  }

  async confirmSuccess(): Promise<void> {
    await this.successOk.tap();
  }

  async expectError(message: string): Promise<void> {
    await expect(this.error).toHaveText(message);
  }
}
