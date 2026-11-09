-- TeaLedger Supabase schema
-- Run this entire script in Supabase Dashboard > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null check (length(trim(name)) > 0),
  phone text,
  created_at timestamptz not null default now()
);

create table if not exists public.ledger_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  customer_id uuid not null references public.customers(id) on delete cascade,
  entry_date date not null default current_date,
  type text not null check (type in ('credit','payment')),
  amount numeric(12,2) not null check (amount > 0),
  note text,
  created_at timestamptz not null default now()
);

alter table public.customers enable row level security;
alter table public.ledger_entries enable row level security;

create policy "Users manage their own customers"
on public.customers for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Users manage their own ledger entries"
on public.ledger_entries for all
using (auth.uid() = user_id)
with check (
  auth.uid() = user_id and exists (
    select 1 from public.customers c
    where c.id = customer_id and c.user_id = auth.uid()
  )
);

create index if not exists customers_user_name_idx on public.customers(user_id, name);
create index if not exists ledger_customer_date_idx on public.ledger_entries(customer_id, entry_date desc);
