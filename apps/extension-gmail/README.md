# @task-capture/extension-gmail

Chrome (MV3) extension that adds a **Create task** affordance to Gmail,
runs structured task extraction against the Task Capture API, and saves
the result.

## Folders

```
src/
  content/          # Gmail content script (button + capture + modal launcher)
  modal/            # Vanilla-DOM editable task modal
  background/       # MV3 service worker — proxies API calls, owns settings
  popup/            # Minimal popup to configure the API base URL
  shared/           # types, runtime messages, settings helpers
public/
  manifest.json     # MV3 manifest (host_permissions: localhost:4000 by default)
```

## Build

```bash
pnpm --filter @task-capture/extension-gmail run build
```

This produces `dist/` with three independently-bundled entry points
(`content.js`, `background.js`, `popup/`) plus the manifest. Each entry is
inlined into a single file so MV3 can load them without cross-file imports.

## Load in Chrome

1. Run the API: `pnpm --filter @task-capture/api dev` (defaults to
   `http://localhost:4000`).
2. Build the extension (above).
3. Visit `chrome://extensions`, enable **Developer mode**.
4. Click **Load unpacked** and select `apps/extension-gmail/dist`.
5. Open Gmail, open any conversation; the **+ Create task** button appears
   in the bottom-right of the page.

If your API isn't on `http://localhost:4000`, click the extension icon and
update the API base URL — the value is stored via `chrome.storage.local`.

## Flow

1. User opens an email and clicks **+ Create task**.
2. Content script scrapes the Gmail DOM (subject, sender, body, timestamp,
   URL, snippet) and shows a loading modal.
3. Background worker `POST /api/v1/extract-task` with the captured payload.
4. The modal shows the editable suggestion (title, summary, priority, due
   date, reminder) and the extractor's confidence.
5. On **Save**, the background worker `POST /api/v1/tasks` with the edited
   form plus a `gmail` `TaskSource` referencing the original email.

All API failures (network, 4xx/5xx, malformed bodies) surface inline in
the modal as a status row; the dialog never crashes Gmail.
