/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  transpilePackages: ["@task-capture/ui", "@task-capture/shared"],
  typedRoutes: true,
};

export default nextConfig;
