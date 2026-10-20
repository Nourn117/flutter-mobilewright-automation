import { expect } from '@mobilewright/test';
import type { Locator, Screen } from 'mobilewright';

type ScrollDirection = 'up' | 'down';

/** First screen after an app relaunch can take a while on a Flutter debug build. */
export const APP_START_TIMEOUT = 30_000;

/** Time for the keyboard close animation (and the layout shift it causes) to finish. */
const KEYBOARD_SETTLE_MS = 800;

/** Shared helpers for every screen / page object. */
export abstract class BasePage {
  constructor(protected readonly screen: Screen) {}

  /** Element by Flutter `Semantics(identifier)` (Android resource-id). */
  protected byId(testId: string): Locator {
    return this.screen.getByTestId(testId);
  }

  /** Element by visible text. `exact: false` matches a substring (case-insensitive). */
  protected byText(text: string | RegExp, exact = true): Locator {
    return this.screen.getByText(text, { exact });
  }

  /**
   * Swipes until the element is visible.
   * We don't use `locator.scrollIntoViewIfNeeded()` because on Android it compares
   * pixel bounds with the screen size in points, so it keeps swiping for elements
   * in the lower half of the screen.
   * 'up' = finger moves up = content scrolls down (reveals lower elements).
   */
  protected async reveal(locator: Locator, direction: ScrollDirection = 'up', maxSwipes = 8): Promise<void> {
    for (let attempt = 0; attempt <= maxSwipes; attempt++) {
      if (await locator.isVisible({ timeout: attempt === 0 ? 2_000 : 700 })) return;
      if (attempt < maxSwipes) await this.screen.swipe(direction, { distance: 600 });
    }
    throw new Error(`Element not visible after ${maxSwipes} swipes (${direction})`);
  }

  /** Reveals the element (if needed) and taps it. */
  protected async tap(locator: Locator, direction: ScrollDirection = 'up'): Promise<void> {
    await this.reveal(locator, direction);
    await locator.tap();
  }

  /**
   * A non-interactive element on this screen (e.g. the title).
   * Tapping it closes the keyboard, because the app unfocuses text fields on tap outside.
   * Pages with text fields override this.
   */
  protected keyboardDismissArea(): Locator | undefined {
    return undefined;
  }

  /**
   * Closes the on-screen keyboard so it doesn't cover buttons or fields below,
   * then waits for the layout to settle: while the keyboard animates away the
   * screen moves, and a tap during that time lands on the old position.
   */
  async hideKeyboard(): Promise<void> {
    const area = this.keyboardDismissArea();
    if (!area) return;
    await area.tap();
    await new Promise((resolve) => setTimeout(resolve, KEYBOARD_SETTLE_MS));
  }

  /**
   * Reveals the field (if needed), replaces its text and closes the keyboard.
   * On Android the text is set on the *focused* field, so we tap first and wait
   * until the field really has focus — otherwise the text can go nowhere.
   */
  protected async fill(locator: Locator, value: string, direction: ScrollDirection = 'up'): Promise<void> {
    await this.reveal(locator, direction);
    await locator.tap();
    await expect(locator).toBeFocused({ timeout: 5_000 });
    await locator.fill(value);
    await this.hideKeyboard();
  }

  /** Asserts that a message (e.g. a validation error) is shown somewhere on the screen. */
  async expectMessage(message: string): Promise<void> {
    await expect(this.byText(message, false).first()).toBeVisible();
  }

  /** Asserts that a message is NOT shown on the screen. */
  async expectNoMessage(message: string): Promise<void> {
    await expect(this.byText(message, false)).toHaveCount(0);
  }

  /** Android system back. */
  async pressBack(): Promise<void> {
    await this.screen.goBack();
  }
}
