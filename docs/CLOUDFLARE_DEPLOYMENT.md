# Cloudflare deployment notes — StockPilot

This repository uses a conventional Express BFF and MySQL. The frontend can be hosted on Cloudflare Pages. The Express server should run on a Node.js-compatible host unless you intentionally port the API to Cloudflare Workers.

## Frontend on Cloudflare Pages

1. Push this repository to GitHub.
2. In Cloudflare Dashboard, open **Workers & Pages → Create → Pages → Connect to Git**.
3. Set the project root directory to `client`.
4. Build command: `npm run build`.
5. Build output directory: `dist`.
6. Add the environment variable `VITE_API_BASE_URL` pointing to the public HTTPS URL of the BFF.
7. Deploy, then set the BFF's `CLIENT_ORIGIN` to the exact Pages origin.

## BFF and database

- Deploy `server` to a Node.js-compatible service and set its root directory to `server`.
- Configure `PORT`, `CLIENT_ORIGIN`, `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, and `DB_NAME` as encrypted environment variables.
- Use a managed MySQL database and restrict network access to the BFF where possible.
- Use HTTPS end-to-end and configure CORS to allow only the frontend origin.
- Do not commit `.env` files or database credentials.

## If using Cloudflare Workers for the BFF

The Express server is **not a drop-in Workers deployment**. Port the route handlers to a Workers-compatible router and use Cloudflare Hyperdrive to connect to MySQL, then test transaction behavior and connection handling. Keep database credentials in Cloudflare secrets, not source code.

## Pre-launch checklist

- Add authentication and role-based authorization.
- Confirm production CORS origins and rate limits.
- Test invalid input, missing records, and database outages.
- Add structured logs and error monitoring.
- Run dependency/security checks and document the rollback procedure.
