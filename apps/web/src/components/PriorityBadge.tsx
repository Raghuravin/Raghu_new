import type { TaskPriority } from "@task-capture/shared";

const STYLES: Record<TaskPriority, string> = {
  urgent: "bg-red-50 text-red-700 ring-red-600/20",
  high: "bg-amber-50 text-amber-800 ring-amber-600/20",
  medium: "bg-neutral-100 text-neutral-700 ring-neutral-600/20",
  low: "bg-neutral-50 text-neutral-500 ring-neutral-400/20",
};

const LABELS: Record<TaskPriority, string> = {
  urgent: "Urgent",
  high: "High",
  medium: "Medium",
  low: "Low",
};

export function PriorityBadge({ priority }: { priority: TaskPriority }) {
  return (
    <span
      className={`inline-flex items-center rounded-md px-2 py-0.5 text-xs font-medium ring-1 ring-inset ${STYLES[priority]}`}
    >
      {LABELS[priority]}
    </span>
  );
}
