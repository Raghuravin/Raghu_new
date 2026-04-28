export function formatRelativeDay(iso: string | null, now: Date = new Date()): string {
  if (!iso) return "No due date";
  const due = new Date(iso);
  const startToday = new Date(now);
  startToday.setHours(0, 0, 0, 0);
  const startDue = new Date(due);
  startDue.setHours(0, 0, 0, 0);

  const dayDiff = Math.round((startDue.getTime() - startToday.getTime()) / 86_400_000);

  const time = due.toLocaleTimeString("en-US", {
    hour: "numeric",
    minute: "2-digit",
  });

  if (dayDiff === 0) return `Today · ${time}`;
  if (dayDiff === 1) return `Tomorrow · ${time}`;
  if (dayDiff === -1) return `Yesterday · ${time}`;
  if (dayDiff > 1 && dayDiff <= 7) {
    return `${due.toLocaleDateString("en-US", { weekday: "long" })} · ${time}`;
  }
  return due.toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: dayDiff < -180 || dayDiff > 180 ? "numeric" : undefined,
  });
}

export function formatCompletedAt(iso: string | null): string {
  if (!iso) return "Completed";
  const d = new Date(iso);
  return `Completed ${d.toLocaleDateString("en-US", { month: "short", day: "numeric" })}`;
}
