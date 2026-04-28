import { PageHeader } from "../../components/PageHeader";
import { TaskList } from "../../components/TaskList";
import { getTasks } from "../../lib/tasks";

export default function UpcomingPage() {
  const tasks = getTasks("upcoming");
  return (
    <>
      <PageHeader
        title="Upcoming"
        description="Tasks scheduled after today, plus tasks without a due date."
        count={tasks.length}
      />
      <TaskList tasks={tasks} emptyMessage="No upcoming tasks. Check back later." />
    </>
  );
}
