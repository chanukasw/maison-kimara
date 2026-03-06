#!/bin/bash

set -e

echo "=========================================="
echo "🚀 MAISON KIMARA - Local Setup"
echo "=========================================="
echo ""

# ============================================
# 1. CONFIG FILES
# ============================================

echo "Creating config files..."

cat > package.json << 'PKGJSON'
{
  "name": "maison-kimara",
  "version": "1.0.0",
  "description": "E-commerce website for MAISON KIMARA",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "^14.0.4",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "typescript": "^5.3.3",
    "tailwindcss": "^3.3.6",
    "zustand": "^4.4.2",
    "axios": "^1.6.2"
  },
  "devDependencies": {
    "@types/node": "^20.10.6",
    "@types/react": "^18.2.46",
    "@types/react-dom": "^18.2.18",
    "autoprefixer": "^10.4.16",
    "postcss": "^8.4.32"
  }
}
PKGJSON
echo "✅ package.json"

cat > tsconfig.json << 'TSCFG'
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "esModuleInterop": true,
    "strict": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "preserve",
    "incremental": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
TSCFG
echo "✅ tsconfig.json"

cat > next.config.js << 'NEXTCFG'
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
NEXTCFG
echo "✅ next.config.js"

cat > tailwind.config.ts << 'TWCFG'
import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './app/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          black: '#000000',
          white: '#FFFFFF',
        },
      },
    },
  },
  plugins: [],
};

export default config;
TWCFG
echo "✅ tailwind.config.ts"

cat > postcss.config.js << 'POSTCSSCFG'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
POSTCSSCFG
echo "✅ postcss.config.js"

cat > .env.example << 'ENVEX'
NODE_ENV=development
NEXT_PUBLIC_API_ENDPOINT=http://localhost:5000
NEXT_PUBLIC_COGNITO_REGION=us-east-1
NEXT_PUBLIC_COGNITO_USER_POOL_ID=
NEXT_PUBLIC_COGNITO_CLIENT_ID=
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=
ENVEX
echo "✅ .env.example"

cat > .gitignore << 'GITIGNORE'
node_modules/
package-lock.json
yarn.lock
.env
.env.local
.env.production
.next/
dist/
build/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
logs/
.pm2/
.DS_Store
.vscode/
.idea/
*.swp
*.swo
coverage/
GITIGNORE
echo "✅ .gitignore"

# ============================================
# 2. APP FILES (Next.js)
# ============================================

echo "Creating app files..."

cat > app/layout.tsx << 'LAYOUT'
import type { Metadata } from 'next';
import './globals.css';
import Header from '@/components/Header';
import Footer from '@/components/Footer';

export const metadata: Metadata = {
  title: 'MAISON KIMARA - Premium Clothing',
  description: 'Discover premium T-shirts and Trousers for Men and Women',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="bg-white text-gray-900">
        <Header />
        <main className="min-h-screen">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
LAYOUT
echo "✅ app/layout.tsx"

cat > app/page.tsx << 'PAGE'
import Hero from '@/components/Hero';
import ProductGrid from '@/components/ProductGrid';

export default function Home() {
  return (
    <>
      <Hero />
      <section className="px-6 py-16 max-w-7xl mx-auto">
        <h2 className="text-4xl font-light mb-12">Featured Collections</h2>
        <ProductGrid />
      </section>
    </>
  );
}
PAGE
echo "✅ app/page.tsx"

cat > app/globals.css << 'GLOBALS'
@tailwind base;
@tailwind components;
@tailwind utilities;

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

a {
  color: inherit;
  text-decoration: none;
}

button {
  cursor: pointer;
  border: none;
  background: none;
}
GLOBALS
echo "✅ app/globals.css"

# ============================================
# 3. COMPONENTS
# ============================================

echo "Creating components..."

cat > components/Header.tsx << 'HEADER'
'use client';

import Link from 'next/link';
import { useState } from 'react';
import { useAuthStore } from '@/lib/store/auth';

export default function Header() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { user, logout } = useAuthStore();

  return (
    <header className="border-b border-gray-200 sticky top-0 bg-white z-50">
      <nav className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
        <Link href="/" className="text-lg font-light tracking-wider">
          MAISON KIMARA
        </Link>

        <div className="hidden md:flex items-center space-x-8">
          <Link href="/products?category=women" className="hover:text-gray-600">WOMEN</Link>
          <Link href="/products?category=men" className="hover:text-gray-600">MEN</Link>
          <Link href="/products?category=kids" className="hover:text-gray-600">KIDS</Link>
        </div>

        <div className="flex items-center space-x-6">
          <Link href="/search">🔍</Link>
          <Link href="/cart">🛒</Link>
          {user ? (
            <button onClick={() => logout()}>Logout</button>
          ) : (
            <Link href="/auth/login">Login</Link>
          )}
        </div>

        <button className="md:hidden" onClick={() => setMobileMenuOpen(!mobileMenuOpen)}>
          ☰
        </button>
      </nav>

      {mobileMenuOpen && (
        <div className="md:hidden border-t border-gray-200 px-6 py-4 space-y-4">
          <Link href="/products?category=women" className="block">WOMEN</Link>
          <Link href="/products?category=men" className="block">MEN</Link>
          <Link href="/products?category=kids" className="block">KIDS</Link>
        </div>
      )}
    </header>
  );
}
HEADER
echo "✅ components/Header.tsx"

cat > components/Hero.tsx << 'HERO'
export default function Hero() {
  return (
    <section className="h-screen bg-gradient-to-r from-gray-100 to-gray-50 flex items-center">
      <div className="max-w-7xl mx-auto px-6">
        <h1 className="text-6xl md:text-7xl font-light tracking-wider mb-6">
          MAISON<br />KIMARA
        </h1>
        <p className="text-lg md:text-2xl font-light text-gray-600 mb-8">
          Premium clothing for the modern individual
        </p>
        <div className="flex gap-4">
          <button className="px-8 py-3 bg-black text-white hover:bg-gray-800 transition">
            Shop Now
          </button>
          <button className="px-8 py-3 border border-black hover:bg-black hover:text-white transition">
            Learn More
          </button>
        </div>
      </div>
    </section>
  );
}
HERO
echo "��� components/Hero.tsx"

cat > components/ProductGrid.tsx << 'GRID'
'use client';

import { useEffect, useState } from 'react';

interface Product {
  id: string;
  name: string;
  price: number;
  image: string;
}

export default function ProductGrid() {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_ENDPOINT}/api/products?limit=8`
        );
        if (!response.ok) throw new Error('Failed to fetch');
        const data = await response.json();
        setProducts(data.items || []);
      } catch (error) {
        console.error('Error:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  if (loading) return <div className="text-center py-12">Loading...</div>;

  if (products.length === 0) {
    return <div className="text-center py-12 text-gray-500">No products yet</div>;
  }

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      {products.map((product) => (
        <div key={product.id} className="group">
          <div className="bg-gray-100 aspect-square mb-4 overflow-hidden rounded">
            <img
              src={product.image}
              alt={product.name}
              className="w-full h-full object-cover group-hover:scale-105 transition"
            />
          </div>
          <h3 className="font-light text-lg">{product.name}</h3>
          <p className="text-gray-600">${product.price}</p>
        </div>
      ))}
    </div>
  );
}
GRID
echo "✅ components/ProductGrid.tsx"

cat > components/Footer.tsx << 'FOOTER'
import Link from 'next/link';

export default function Footer() {
  const year = new Date().getFullYear();

  return (
    <footer className="border-t border-gray-200 bg-gray-50 py-12">
      <div className="max-w-7xl mx-auto px-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
          <div>
            <h3 className="font-light text-lg mb-4">MAISON KIMARA</h3>
            <p className="text-sm text-gray-600">Premium clothing for everyone</p>
          </div>
          <div>
            <h4 className="font-light mb-4">Shop</h4>
            <ul className="space-y-2 text-sm">
              <li><Link href="/products?category=women" className="text-gray-600 hover:text-black">Women</Link></li>
              <li><Link href="/products?category=men" className="text-gray-600 hover:text-black">Men</Link></li>
              <li><Link href="/products?category=kids" className="text-gray-600 hover:text-black">Kids</Link></li>
            </ul>
          </div>
          <div>
            <h4 className="font-light mb-4">Help</h4>
            <ul className="space-y-2 text-sm">
              <li><Link href="/contact" className="text-gray-600 hover:text-black">Contact</Link></li>
              <li><Link href="/faq" className="text-gray-600 hover:text-black">FAQ</Link></li>
            </ul>
          </div>
          <div>
            <h4 className="font-light mb-4">Legal</h4>
            <ul className="space-y-2 text-sm">
              <li><Link href="/privacy" className="text-gray-600 hover:text-black">Privacy</Link></li>
              <li><Link href="/terms" className="text-gray-600 hover:text-black">Terms</Link></li>
            </ul>
          </div>
        </div>
        <div className="border-t border-gray-200 pt-8 text-center text-sm text-gray-600">
          <p>&copy; {year} MAISON KIMARA. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
}
FOOTER
echo "✅ components/Footer.tsx"

# ============================================
# 4. STATE MANAGEMENT
# ============================================

echo "Creating state management..."

cat > lib/store/auth.ts << 'AUTH'
import { create } from 'zustand';

interface User {
  id: string;
  email: string;
  name: string;
}

interface AuthStore {
  user: User | null;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
  setUser: (user: User | null) => void;
}

export const useAuthStore = create<AuthStore>((set) => ({
  user: null,
  login: async (email: string, password: string) => {
    try {
      const response = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password }),
      });
      if (!response.ok) throw new Error('Login failed');
      const data = await response.json();
      set({ user: data.user });
    } catch (error) {
      console.error('Login error:', error);
    }
  },
  logout: () => set({ user: null }),
  setUser: (user) => set({ user }),
}));
AUTH
echo "✅ lib/store/auth.ts"

cat > lib/store/cart.ts << 'CART'
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

export interface CartItem {
  productId: string;
  name: string;
  price: number;
  quantity: number;
  size: string;
  image: string;
}

interface CartStore {
  items: CartItem[];
  addItem: (item: CartItem) => void;
  removeItem: (productId: string, size: string) => void;
  updateQuantity: (productId: string, size: string, quantity: number) => void;
  clearCart: () => void;
  getTotal: () => number;
}

export const useCartStore = create<CartStore>()(
  persist(
    (set, get) => ({
      items: [],
      addItem: (item) =>
        set((state) => {
          const existing = state.items.find(
            (i) => i.productId === item.productId && i.size === item.size
          );
          if (existing) {
            return {
              items: state.items.map((i) =>
                i.productId === item.productId && i.size === item.size
                  ? { ...i, quantity: i.quantity + item.quantity }
                  : i
              ),
            };
          }
          return { items: [...state.items, item] };
        }),
      removeItem: (productId, size) =>
        set((state) => ({
          items: state.items.filter(
            (i) => !(i.productId === productId && i.size === size)
          ),
        })),
      updateQuantity: (productId, size, quantity) =>
        set((state) => ({
          items: state.items
            .map((i) =>
              i.productId === productId && i.size === size
                ? { ...i, quantity: Math.max(0, quantity) }
                : i
            )
            .filter((i) => i.quantity > 0),
        })),
      clearCart: () => set({ items: [] }),
      getTotal: () =>
        get().items.reduce((sum, item) => sum + item.price * item.quantity, 0),
    }),
    { name: 'maison-kimara-cart' }
  )
);
CART
echo "✅ lib/store/cart.ts"

# ============================================
# 5. NGINX CONFIG (for reference)
# ============================================

echo "Creating NGINX configuration..."

cat > nginx/maison-kimara.conf << 'NGINX'
upstream nextjs_backend {
    server 127.0.0.1:3000;
    keepalive 64;
}

server {
    listen 80;
    listen [::]:80;
    server_name _;
    
    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
    
    location / {
        return 301 https://$server_name$request_uri;
    }
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name _;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;

    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header X-Frame-Options "SAMEORIGIN" always;

    access_log /var/log/nginx/maison-kimara-access.log;
    error_log /var/log/nginx/maison-kimara-error.log;

    gzip on;
    gzip_types text/plain text/css text/javascript application/json;

    location ~* \.(js|css|png|jpg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    location / {
        proxy_pass http://nextjs_backend;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    location ~ /\. {
        deny all;
    }
}
NGINX
echo "✅ nginx/maison-kimara.conf"

# ============================================
# 6. PM2 ECOSYSTEM CONFIG
# ============================================

echo "Creating PM2 configuration..."

cat > ecosystem.config.js << 'PM2'
module.exports = {
  apps: [
    {
      name: 'maison-kimara-frontend',
      script: 'npm',
      args: 'start',
      instances: 'max',
      exec_mode: 'cluster',
      env: {
        NODE_ENV: 'production',
        PORT: 3000,
      },
      error_file: '/var/log/pm2/maison-kimara-error.log',
      out_file: '/var/log/pm2/maison-kimara-out.log',
      autorestart: true,
      max_memory_restart: '1G',
    },
  ],
};
PM2
echo "✅ ecosystem.config.js"

# ============================================
# 7. DEPLOYMENT SCRIPTS
# ============================================

echo "Creating deployment scripts..."

cat > scripts/quick-setup.sh << 'DEPLOY'
#!/bin/bash
set -e

echo "=========================================="
echo "🚀 MAISON KIMARA - Server Setup"
echo "=========================================="

DOMAIN=${1:-"yourdomain.com"}
EMAIL=${2:-"admin@yourdomain.com"}

echo "Domain: $DOMAIN"
echo "Email: $EMAIL"
echo ""

# Update system
echo "📦 Updating system..."
sudo apt-get update
sudo apt-get upgrade -y

# Install dependencies
echo "📦 Installing dependencies..."
sudo apt-get install -y nodejs npm nginx git curl certbot python3-certbot-nginx

# Install PM2 globally
echo "📦 Installing PM2..."
sudo npm install -g pm2

# Create log directory
echo "📦 Creating log directories..."
sudo mkdir -p /var/log/pm2
sudo chown -R $USER:$USER /var/log/pm2

# Install Node dependencies
echo "📦 Installing Node dependencies..."
npm install --production

# Build Next.js application
echo "🔨 Building application..."
npm run build

# Setup NGINX
echo "⚙️  Setting up NGINX..."
sudo cp nginx/maison-kimara.conf /etc/nginx/sites-available/
sudo sed -i "s/yourdomain.com/$DOMAIN/g" /etc/nginx/sites-available/maison-kimara.conf
sudo ln -sf /etc/nginx/sites-available/maison-kimara.conf /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx

# Create certbot directory
echo "🔒 Setting up SSL..."
sudo mkdir -p /var/www/certbot
sudo certbot certonly --webroot -w /var/www/certbot \
  -d $DOMAIN -d www.$DOMAIN \
  --email $EMAIL --agree-tos --non-interactive

# Start PM2
echo "🚀 Starting application with PM2..."
pm2 start ecosystem.config.js
pm2 save
pm2 startup

echo ""
echo "=========================================="
echo "✅ Server setup complete!"
echo "=========================================="
echo ""
echo "Visit: https://$DOMAIN"
echo ""
echo "Useful commands:"
echo "  pm2 list           - Check app status"
echo "  pm2 logs           - View logs"
echo "  pm2 stop all       - Stop apps"
echo "  pm2 restart all    - Restart apps"
echo ""
DEPLOY
chmod +x scripts/quick-setup.sh
echo "✅ scripts/quick-setup.sh"

# ============================================
# 8. DOCUMENTATION
# ============================================

echo "Creating documentation..."

cat > README.md << 'README'
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