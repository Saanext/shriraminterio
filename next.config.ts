
import type {NextConfig} from 'next';

const nextConfig: NextConfig = {
  env: {
    NEXT_PUBLIC_SUPABASE_URL: 'https://gzlakbpbhhxxpzbbifus.supabase.co',
    NEXT_PUBLIC_SUPABASE_ANON_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd6bGFrYnBiaGh4eHB6YmJpZnVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYyNzkxMzgsImV4cCI6MjA3MTg1NTEzOH0.0FUtreVqUqsXNBe42-waiyHmrAsnytLT1VvXjo_1KPQ',
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  eslint: {
    ignoreDuringBuilds: true,
  },
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'images.unsplash.com',
      },
      {
        protocol: 'https',
        hostname: 'placehold.co',
      },
       {
        protocol: 'https',
        hostname: 'gzlakbpbhhxxpzbbifus.supabase.co',
      }
    ],
  },
};

export default nextConfig;
