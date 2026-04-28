import { PageHeader } from "../../components/PageHeader";
import { TaskList } from "../../components/TaskList";
import { getTasks } from "../../lib/tasks";

export default function TodayPage() {
  const tasks = getTasks("today");
  return (
    <>
      <PageHeader
        title="Today"
        description="Tasks due today, sorted by time."
        count={tasks.length}
      />
      <TaskList tasks={tasks} emptyMessage="Nothing due today. Inbox zero vibes." />
    </>
  );
}
