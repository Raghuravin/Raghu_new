"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

import type { TaskBucket } from "../lib/tasks";

interface NavItem {
  href: string;
  label: string;
  bucket: TaskBucket;
}

const NAV: readonly NavItem[] = [
  { href: "/today", label: "Today", bucket: "today" },
  { href: "/upcoming", label: "Upcoming", bucket: "upcoming" },
  { href: "/done", label: "Done", bucket: "done" },
] as const;

export function Sidebar({ counts }: { counts: Record<TaskBucket, number> }) {
  const pathname = usePathname();
  return (
    <aside className="flex h-full w-56 shrink-0 flex-col border-r border-neutral-200 bg-white px-3 py-6">
      <div className="px-3 pb-6">
        <h1 className="text-base font-semibold tracking-tight text-neutral-900">Task Capture</h1>
        <p className="mt-0.5 text-xs text-neutral-500">Internal MVP</p>
      </div>
      <nav className="flex flex-col gap-0.5">
        {NAV.map((item) => {
          const active = pathname === item.href;
          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex items-center justify-between rounded-md px-3 py-1.5 text-sm font-medium transition ${
                active
                  ? "bg-neutral-100 text-neutral-900"
                  : "text-neutral-600 hover:bg-neutral-50 hover:text-neutral-900"
              }`}
            >
              <span>{item.label}</span>
              <span
                className={`rounded px-1.5 text-xs ${
                  active ? "bg-white text-neutral-700" : "text-neutral-400"
                }`}
              >
                {counts[item.bucket]}
              </span>
            </Link>
          );
        })}
      </nav>
    </aside>
  );
}
