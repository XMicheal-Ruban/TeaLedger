# TeaLedger — Tea Shop Credit Management

A responsive starter app for recording customer credit and salary-day repayments.

## Included
- Customer list with search
- Daily credit entries and payment entries
- Live outstanding balance per customer and across the shop
- Monthly opening balance, new credit, payments and closing balance
- CSV export for each customer's ledger
- Mobile and laptop responsive layout
- Supabase cloud-backup integration (requires your own project)

## Try it locally
1. Extract the ZIP.
2. Open `index.html` in Chrome or Edge.
3. In local mode, click **Sign in** (no password required).
4. Add customers and record credit/payments.

**Local mode stores data only in that browser on that device.** Clearing browser data or changing devices can lose access to those records. Export CSV backups regularly until cloud sync is connected.

## Enable online backup (Supabase)
1. Create a free project at https://supabase.com/.
2. In the Supabase project, open **SQL Editor**, paste all of `supabase-schema.sql`, and run it.
3. Open **Project Settings → API** and copy the Project URL and `anon`/publishable key.
4. In `index.html`, find:
   ```js
   const SUPABASE_URL = "";
   const SUPABASE_ANON_KEY = "";
   ```
   Paste the Project URL and anon/public key between the quotes. Never put a `service_role` key in browser code.
5. Save and reopen the app. Create an account using your email and password, verify email if prompted, then sign in.

The SQL enables Row Level Security so each signed-in account can access only its own customer records. Do not disable RLS or share your password/key.

## Put it online for mobile + laptop
Deploy the folder as a static site using a host such as Netlify, Vercel, or GitHub Pages. After deployment, open the same HTTPS site on your phone and laptop and sign in with the same account. Supabase then keeps the ledger synchronized.

## Important limitations in this starter
- This is a first usable version, not yet a polished production accounting system.
- The current app has no edit/delete controls for transactions; correct mistakes by adding a correcting entry (for example, a payment/credit adjustment) and a note.
- Configure Supabase Auth email confirmation and password recovery in the Supabase dashboard before relying on it.
- Add regular CSV exports as an extra backup.
