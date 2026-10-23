# StockPilot — Inventory & Order Management

A full-stack inventory control app for small teams. Built with React, TypeScript, Tailwind CSS, Express BFF, and MySQL.

## Features
- Product catalogue with category, SKU, price, and on-hand stock
- Search, low-stock filters, and stock value summary
- Create products and receive inventory
- Record a sale/order with a MySQL transaction that prevents overselling
- Validated API inputs, parameterized SQL, Helmet, and rate limiting
- Responsive dashboard and API health endpoint

## Architecture
`React + Vite → Express BFF /api → MySQL`

## Requirements
Node.js 20+ and MySQL 8+.

## Run locally
1. Execute `server/db/schema.sql` in MySQL.
2. Copy `server/.env.example` to `server/.env` and set DB credentials.
3. Start the BFF:
   ```bash
   cd server && npm install && npm run dev
   ```
4. In another terminal start the UI:
   ```bash
   cd client && npm install && npm run dev
   ```
5. Open the Vite URL in your browser. The default BFF URL is `http://localhost:4001`.

## API
- `GET /api/health`
- `GET /api/products?search=keyboard&lowStock=true`
- `POST /api/products`
- `POST /api/products/:id/receive`
- `POST /api/orders` — atomically reduces stock and records the order

## Production notes
Add authentication and authorization, audit trails, pagination, and idempotency keys for order creation before production use. Use a managed MySQL service, keep secrets in environment variables, and restrict CORS to the deployed UI domain.


## Cloudflare deployment
See [`docs/CLOUDFLARE_DEPLOYMENT.md`](docs/CLOUDFLARE_DEPLOYMENT.md) for a deployment outline for Cloudflare Pages, a Node-compatible BFF host, and production hardening.
