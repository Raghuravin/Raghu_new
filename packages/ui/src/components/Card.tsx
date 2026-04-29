import type { HTMLAttributes, JSX, ReactNode } from "react";

export interface CardProps extends HTMLAttributes<HTMLDivElement> {
  title?: string;
  children: ReactNode;
}

export function Card({ title, children, className, ...rest }: CardProps): JSX.Element {
  const cls = ["tc-card", className].filter(Boolean).join(" ");
  return (
    <div className={cls} {...rest}>
      {title ? <h3 className="tc-card__title">{title}</h3> : null}
      <div className="tc-card__body">{children}</div>
    </div>
  );
}
