import { PageHeader } from "../../components/PageHeader";
import { TaskList } from "../../components/TaskList";
import { getTasks } from "../../lib/tasks";

export const dynamic = "force-dynamic";

export default async function DonePage() {
  const { tasks, error } = await getTasks("done");
  return (
    <>
      <PageHeader title="Done" description="Recently completed tasks." count={tasks.length} />
      <TaskList tasks={tasks} emptyMessage="No completed tasks yet." error={error} />
    </>
  );
}
