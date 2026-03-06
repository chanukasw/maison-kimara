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
