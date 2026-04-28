const BUTTON_ID = "tc-create-task-btn";

/**
 * Ensures a single "Create task" button exists in the DOM. The button is
 * positioned as a small floating affordance in the lower-right corner —
 * Gmail's toolbar internals are too volatile to anchor reliably across
 * releases, so a fixed-position FAB is the most resilient minimal UI.
 */
export function ensureCreateTaskButton(onClick: () => void): void {
  if (document.getElementById(BUTTON_ID)) return;

  const btn = document.createElement("button");
  btn.id = BUTTON_ID;
  btn.type = "button";
  btn.className = "tc-fab";
  btn.setAttribute("aria-label", "Create task from this email");
  btn.title = "Create task from this email";
  btn.textContent = "+ Create task";
  btn.addEventListener("click", (e) => {
    e.preventDefault();
    e.stopPropagation();
    onClick();
  });

  document.body.appendChild(btn);
}

export function showButton(visible: boolean): void {
  const btn = document.getElementById(BUTTON_ID);
  if (!btn) return;
  btn.style.display = visible ? "" : "none";
}
