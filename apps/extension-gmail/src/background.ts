/**
 * Background service worker for the Task Capture Chrome extension.
 * Scaffold only — wire OAuth, message handling, and reminders here.
 */
chrome.runtime.onInstalled.addListener(() => {
  console.log("[task-capture] background service worker installed");
});
