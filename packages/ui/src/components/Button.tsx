import type { ButtonHTMLAttributes, JSX, ReactNode } from "react";

export type ButtonVariant = "primary" | "secondary" | "ghost";

export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ButtonVariant;
  children: ReactNode;
}

const variantClass: Record<ButtonVariant, string> = {
  primary: "tc-btn tc-btn--primary",
  secondary: "tc-btn tc-btn--secondary",
  ghost: "tc-btn tc-btn--ghost",
};

export function Button({
  variant = "primary",
  className,
  children,
  ...rest
}: ButtonProps): JSX.Element {
  const cls = [variantClass[variant], className].filter(Boolean).join(" ");
  return (
    <button className={cls} {...rest}>
      {children}
    </button>
  );
}
