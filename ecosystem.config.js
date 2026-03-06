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
