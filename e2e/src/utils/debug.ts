import type { Screen } from 'mobilewright';

type Nodes = Awaited<ReturnType<Screen['viewTree']>>;

/**
 * Debug helper: prints every element that has an id or a text, with its bounds.
 * Usage inside a test: `await dumpScreen(screen, 'Cart')`. Do not leave it in committed tests.
 */
export async function dumpScreen(screen: Screen, title = 'SCREEN'): Promise<void> {
  const lines: string[] = [];
  const walk = (nodes: Nodes, depth: number) => {
    for (const n of nodes) {
      const text = n.text ?? n.label ?? n.value ?? '';
      const id = n.identifier ?? n.resourceId ?? n.key ?? '';
      if (id.startsWith('com.android.systemui')) continue;
      if (id || text) {
        const b = n.bounds;
        lines.push(
          `${'  '.repeat(Math.min(depth, 12))}[${n.type}] id="${id}" text="${text.replace(/\n/g, '\\n')}" ` +
            `visible=${n.isVisible} checked=${n.isChecked ?? '-'} bounds=(${b.x},${b.y},${b.width}x${b.height})`,
        );
      }
      walk(n.children ?? [], depth + 1);
    }
  };
  walk(await screen.viewTree(), 0);
  console.log(`\n===== ${title} =====\n${lines.join('\n')}\n`);
}
