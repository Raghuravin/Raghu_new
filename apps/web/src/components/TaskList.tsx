import type { Task } from "@task-capture/shared";

import { TaskCard } from "./TaskCard";

export function TaskList({ tasks, emptyMessage }: { tasks: Task[]; emptyMessage: string }) {
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
