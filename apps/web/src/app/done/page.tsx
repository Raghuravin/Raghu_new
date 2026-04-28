import { PageHeader } from "../../components/PageHeader";
import { TaskList } from "../../components/TaskList";
import { getTasks } from "../../lib/tasks";

export default function DonePage() {
  const tasks = getTasks("done");
  return (
    <>
      <PageHeader title="Done" description="Recently completed tasks." count={tasks.length} />
      <TaskList tasks={tasks} emptyMessage="No completed tasks yet." />
    </>
  );
}
