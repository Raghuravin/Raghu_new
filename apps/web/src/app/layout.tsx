import type { Metadata } from "next";
import type { ReactNode } from "react";

import { Sidebar } from "../components/Sidebar";
import { getCounts } from "../lib/tasks";

import "./globals.css";

export const metadata: Metadata = {
  title: "Task Capture",
  description: "Convert Gmail emails into tasks with reminders.",
};

export default async function RootLayout({ children }: { children: ReactNode }) {
  const counts = await getCounts();
  return (
    <html lang="en">
      <body>
        <div className="flex h-screen w-full">
          <Sidebar counts={counts} />
          <main className="flex-1 overflow-y-auto">
            <div className="mx-auto max-w-3xl px-8 py-10">{children}</div>
          </main>
        </div>
      </body>
    </html>
  );
}
