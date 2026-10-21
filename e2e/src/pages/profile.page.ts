import { expect } from '@mobilewright/test';

import { TestIds } from '../data/test-ids';
import type { User } from '../data/users';
import { BasePage } from './base.page';

export class ProfilePage extends BasePage {
  readonly title = this.byText('Profile');
  readonly name = this.byId(TestIds.profileName);
  readonly email = this.byId(TestIds.profileEmail);
  readonly darkMode = this.byId(TestIds.profileDarkMode);
  readonly logoutButton = this.byId(TestIds.profileLogout);
  readonly confirmLogoutButton = this.byId(TestIds.profileConfirmLogout);
  readonly cancelLogoutButton = this.byId(TestIds.profileCancelLogout);

  async expectUser(user: Pick<User, 'name' | 'email'>): Promise<void> {
    await expect(this.name).toHaveText(user.name);
    await expect(this.email).toHaveText(user.email);
  }

  async setDarkMode(enabled: boolean): Promise<void> {
    await this.darkMode.setChecked(enabled);
  }

  async expectDarkMode(enabled: boolean): Promise<void> {
    if (enabled) {
      await expect(this.darkMode).toBeChecked();
    } else {
      await expect(this.darkMode).not.toBeChecked();
    }
  }

  async openLogoutDialog(): Promise<void> {
    await this.logoutButton.tap();
    await this.expectMessage('Log out?');
  }

  async logout(): Promise<void> {
    await this.openLogoutDialog();
    await this.confirmLogoutButton.tap();
  }

  async cancelLogout(): Promise<void> {
    await this.openLogoutDialog();
    await this.cancelLogoutButton.tap();
  }
}
