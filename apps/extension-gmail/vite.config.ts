import { resolve } from "node:path";

import { defineConfig, type UserConfig } from "vite";

/**
 * The extension has three independent entries:
 *   - `src/content/index.ts`   -> dist/content.js  (content script, single file)
 *   - `src/background/index.ts` -> dist/background.js (service worker, single file, ESM)
 *   - `src/popup/index.html`    -> dist/popup/*    (regular HTML bundle)
 *
 * Each is built with its own Vite invocation so the content script and the
 * service worker can use `inlineDynamicImports` (no chunk files referenced
 * across origins). Selected via the `TC_TARGET` env variable; the npm
 * scripts run all three sequentially.
 */
const target = (process.env.TC_TARGET ?? "").toLowerCase();

const outDir = resolve(__dirname, "dist");
const publicDir = resolve(__dirname, "public");

const common = {
  publicDir,
  build: {
    outDir,
    emptyOutDir: false,
    target: "chrome120",
    sourcemap: false,
    minify: false,
  },
} satisfies UserConfig;

let config: UserConfig;

switch (target) {
  case "content":
    config = {
      ...common,
      build: {
        ...common.build,
        emptyOutDir: true, // run first; clears the dist directory
        rollupOptions: {
          input: { content: resolve(__dirname, "src/content/index.ts") },
          output: {
            format: "iife",
            inlineDynamicImports: true,
            entryFileNames: "[name].js",
            assetFileNames: "[name][extname]",
          },
        },
      },
    };
    break;
  case "background":
    config = {
      ...common,
      build: {
        ...common.build,
        rollupOptions: {
          input: { background: resolve(__dirname, "src/background/index.ts") },
          output: {
            format: "es",
            inlineDynamicImports: true,
            entryFileNames: "[name].js",
            assetFileNames: "[name][extname]",
          },
        },
      },
    };
    break;
  case "popup":
    config = {
      ...common,
      root: resolve(__dirname, "src/popup"),
      // Popup is a self-contained HTML bundle at dist/popup/.
      publicDir: false,
      base: "./",
      build: {
        ...common.build,
        outDir: resolve(__dirname, "dist/popup"),
        rollupOptions: {
          input: { popup: resolve(__dirname, "src/popup/index.html") },
          output: {
            entryFileNames: "[name].js",
            chunkFileNames: "chunks/[name]-[hash].js",
            assetFileNames: "[name][extname]",
          },
        },
      },
    };
    break;
  default:
    throw new Error(
      `Unknown TC_TARGET="${target}". Run via the package scripts: pnpm --filter @task-capture/extension-gmail run build`,
    );
}

export default defineConfig(config);
