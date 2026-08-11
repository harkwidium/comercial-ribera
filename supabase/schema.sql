-- COMERCIAL RIBERA · Esquema portable PostgreSQL/Supabase
-- Ejecutar una vez en Supabase > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  slug text not null unique,
  description text,
  image_url text,
  sort_order integer not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references public.categories(id) on delete set null,
  code text not null unique,
  name text not null,
  slug text not null unique,
  brand text,
  description text not null default '',
  price numeric(12,2) not null default 0 check (price >= 0),
  sale_price numeric(12,2) check (sale_price is null or sale_price >= 0),
  stock_quantity numeric(12,2) not null default 0 check (stock_quantity >= 0),
  stock_status text not null default 'consult' check (stock_status in ('available','low_stock','out_of_stock','consult')),
  sale_unit text not null default 'unidad' check (sale_unit in ('unidad','metro','rollo','juego')),
  hose_measure text,
  specifications jsonb not null default '{}'::jsonb,
  image_url text,
  featured boolean not null default false,
  on_sale boolean not null default false,
  published boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint valid_sale_price check (sale_price is null or sale_price <= price)
);

create table if not exists public.product_images (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  url text not null,
  alt_text text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

-- Lista mínima de usuarios con permiso administrativo.
create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists(select 1 from public.admin_users where user_id = auth.uid()) $$;

create or replace function public.touch_updated_at()
returns trigger language plpgsql as $$ begin new.updated_at = now(); return new; end $$;

drop trigger if exists categories_updated_at on public.categories;
create trigger categories_updated_at before update on public.categories for each row execute function public.touch_updated_at();
drop trigger if exists products_updated_at on public.products;
create trigger products_updated_at before update on public.products for each row execute function public.touch_updated_at();

alter table public.categories enable row level security;
alter table public.products enable row level security;
alter table public.product_images enable row level security;
alter table public.admin_users enable row level security;

drop policy if exists "Public reads active categories" on public.categories;
create policy "Public reads active categories" on public.categories for select using (active = true or public.is_admin());
drop policy if exists "Admins manage categories" on public.categories;
create policy "Admins manage categories" on public.categories for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Public reads published products" on public.products;
create policy "Public reads published products" on public.products for select using (published = true or public.is_admin());
drop policy if exists "Admins manage products" on public.products;
create policy "Admins manage products" on public.products for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Public reads product images" on public.product_images;
create policy "Public reads product images" on public.product_images for select using (
  exists(select 1 from public.products p where p.id = product_id and (p.published = true or public.is_admin()))
);
drop policy if exists "Admins manage product images" on public.product_images;
create policy "Admins manage product images" on public.product_images for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "Admins read own role" on public.admin_users;
create policy "Admins read own role" on public.admin_users for select using (user_id = auth.uid());

insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('product-images','product-images',true,3145728,array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public=true,file_size_limit=3145728,allowed_mime_types=array['image/jpeg','image/png','image/webp'];

drop policy if exists "Public views product image files" on storage.objects;
create policy "Public views product image files" on storage.objects for select using (bucket_id='product-images');
drop policy if exists "Admins upload product image files" on storage.objects;
create policy "Admins upload product image files" on storage.objects for insert to authenticated with check (bucket_id='product-images' and public.is_admin());
drop policy if exists "Admins update product image files" on storage.objects;
create policy "Admins update product image files" on storage.objects for update to authenticated using (bucket_id='product-images' and public.is_admin()) with check (bucket_id='product-images' and public.is_admin());
drop policy if exists "Admins delete product image files" on storage.objects;
create policy "Admins delete product image files" on storage.objects for delete to authenticated using (bucket_id='product-images' and public.is_admin());

insert into public.categories(name,slug,sort_order) values
('Desbrozadoras','desbrozadoras',10),('Motobombas','motobombas',20),('Motores','motores',30),
('Compresoras','compresoras',40),('Herramientas','herramientas',50),('Mangueras','mangueras',60),
('Accesorios','accesorios',70),('Repuestos','repuestos',80)
on conflict (slug) do nothing;

-- PASO MANUAL DESPUÉS DE CREAR EL USUARIO EN AUTHENTICATION > USERS:
-- insert into public.admin_users(user_id)
-- select id from auth.users where email = 'TU-CORREO';
