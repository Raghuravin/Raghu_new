import { PageHeader } from "../../components/PageHeader";
import { TaskList } from "../../components/TaskList";
import { getTasks } from "../../lib/tasks";

export const dynamic = "force-dynamic";

export default async function UpcomingPage() {
  const { tasks, error } = await getTasks("upcoming");
  return (
    <>
      <PageHeader
        title="Upcoming"
        description="Tasks scheduled after today, plus tasks without a due date."
        count={tasks.length}
      />
      <TaskList tasks={tasks} emptyMessage="No upcoming tasks. Check back later." error={error} />
    </>
  );
}
