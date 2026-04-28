import type { MockTask } from "../lib/mock-tasks";

import { formatCompletedAt, formatRelativeDay } from "../lib/format";

import { PriorityBadge } from "./PriorityBadge";

export function TaskCard({ task }: { task: MockTask }) {
  const isDone = task.status === "done";
  return (
    <article
      className={`rounded-lg border border-neutral-200 bg-white p-4 transition hover:border-neutral-300 ${
        isDone ? "opacity-70" : ""
      }`}
    >
      <div className="flex items-start gap-3">
        <input
          type="checkbox"
          checked={isDone}
          readOnly
          aria-label={isDone ? "Task completed" : "Mark task complete"}
          className="mt-1 h-4 w-4 cursor-default rounded border-neutral-300 text-neutral-900 focus:ring-neutral-900"
        />
        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2">
            <h3
              className={`text-sm font-medium text-neutral-900 ${
                isDone ? "line-through decoration-neutral-400" : ""
              }`}
            >
              {task.title}
            </h3>
            <PriorityBadge priority={task.priority} />
          </div>
          {task.description ? (
            <p className="mt-1 line-clamp-2 text-sm text-neutral-500">{task.description}</p>
          ) : null}
          <div className="mt-2 flex flex-wrap items-center gap-x-3 gap-y-1 text-xs text-neutral-500">
            <span>
              {isDone ? formatCompletedAt(task.completedAt) : formatRelativeDay(task.dueAt)}
            </span>
            {!isDone && task.nextReminderAt ? (
              <span>· Reminder {formatRelativeDay(task.nextReminderAt)}</span>
            ) : null}
          </div>
        </div>
      </div>
    </article>
  );
}
