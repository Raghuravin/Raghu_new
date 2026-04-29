import type { Task } from "@task-capture/shared";

import { TaskCard } from "./TaskCard";

export interface TaskListError {
  code: string;
  message: string;
}

export function TaskList({
  tasks,
  emptyMessage,
  error,
}: {
  tasks: Task[];
  emptyMessage: string;
  error?: TaskListError | null;
}) {
  if (error) {
    return (
      <div className="rounded-lg border border-red-200 bg-red-50 px-6 py-8 text-center">
        <p className="text-sm font-medium text-red-800">Couldn&apos;t load tasks</p>
        <p className="mt-1 text-xs text-red-700">
          {error.message} <span className="text-red-500">({error.code})</span>
        </p>
        <p className="mt-3 text-xs text-red-700">
          Make sure the API is running at <code>NEXT_PUBLIC_API_URL</code>.
        </p>
      </div>
    );
  }

  if (tasks.length === 0) {
    return (
      <div className="rounded-lg border border-dashed border-neutral-300 bg-white px-6 py-12 text-center">
        <p className="text-sm text-neutral-500">{emptyMessage}</p>
      </div>
    );
  }

  return (
    <ul className="space-y-2">
      {tasks.map((task) => (
        <li key={task.id}>
          <TaskCard task={task} />
        </li>
      ))}
    </ul>
  );
}
