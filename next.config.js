/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: ['d1234567890.cloudfront.net', 'localhost'],
  },
  env: {
    NEXT_PUBLIC_API_ENDPOINT: process.env.NEXT_PUBLIC_API_ENDPOINT || 'http://localhost:5000',
  },
};

module.exports = nextConfig;
