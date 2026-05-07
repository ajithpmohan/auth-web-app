import type { NextConfig } from "next";

const isBackendOnSameServer = process.env.BACKEND_ON_SAME_SERVER === "true";

const nextConfig: NextConfig = {
    async rewrites() {
    if (!isBackendOnSameServer) {
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
