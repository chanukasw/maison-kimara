# MAISON KIMARA - E-Commerce Website

Premium clothing e-commerce platform for MAISON KIMARA.

## 🎯 Features

- 🛍️ Product catalog (Women, Men, Kids)
- 🔐 User authentication
- 🛒 Shopping cart with persistence
- 💳 Payment processing ready
- 📱 Responsive design
- ⚡ Fast performance with Next.js

## 🛠️ Tech Stack

- **Frontend:** Next.js 14, React 18, TypeScript, Tailwind CSS
- **State:** Zustand with persistence
- **Deployment:** NGINX, PM2, Let's Encrypt SSL
- **Database:** Ready for AWS DynamoDB, Cognito
- **Payments:** Ready for Stripe integration

## 🚀 Quick Start - Development

### Prerequisites
- Node.js 18+
- npm or yarn

### Setup
```bash
# Install dependencies
npm install

# Create environment file
cp .env.example .env.local

# Start development server
npm run dev
