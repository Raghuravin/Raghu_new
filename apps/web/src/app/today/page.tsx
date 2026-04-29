import { PageHeader } from "../../components/PageHeader";
import { TaskList } from "../../components/TaskList";
import { getTasks } from "../../lib/tasks";

export const dynamic = "force-dynamic";

export default async function TodayPage() {
  const { tasks, error } = await getTasks("today");
  return (
    <>
      <PageHeader
        title="Today"
        description="Tasks due today, sorted by time."
        count={tasks.length}
      />
      <TaskList tasks={tasks} emptyMessage="Nothing due today. Inbox zero vibes." error={error} />
    </>
  );
}
