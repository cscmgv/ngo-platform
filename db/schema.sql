create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  email text not null unique,
  mobile text not null unique,
  role text not null default 'DONOR' check (role in ('ADMIN','STAFF','VOLUNTEER','DONOR')),
  password_hash text,
  created_at timestamptz not null default now()
);

create table if not exists donors (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text unique,
  mobile text unique,
  pan text,
  address text,
  created_at timestamptz not null default now()
);

create table if not exists donations (
  id uuid primary key default gen_random_uuid(),
  donor_id uuid references donors(id),
  receipt_no text not null unique,
  amount numeric(12,2) not null check (amount > 0),
  payment_mode text not null,
  purpose text,
  donated_at timestamptz not null default now()
);

create table if not exists volunteers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text unique,
  mobile text unique,
  district text,
  status text not null default 'ACTIVE',
  created_at timestamptz not null default now()
);

create table if not exists projects (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  budget numeric(12,2) default 0,
  status text not null default 'ACTIVE',
  created_at timestamptz not null default now()
);

create index if not exists donations_donated_at_idx on donations(donated_at);
create index if not exists donations_donor_id_idx on donations(donor_id);
