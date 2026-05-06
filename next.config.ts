import type { NextConfig } from "next";

const isDev = process.env.NODE_ENV === "development";

const nextConfig: NextConfig = {
    async rewrites() {
    if (isDev) {
      return [
        {
          source: "/api/:path*",
          destination: `${process.env.NEXT_PUBLIC_API_URL}/api/:path*`
        },
      ];
    }
    return [];
  },
};

export default nextConfig;
