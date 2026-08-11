-- Exportación manual sin herramientas de pago.
-- En Supabase SQL Editor, exporta resultados como CSV o usa pg_dump desde un equipo autorizado.
select * from public.categories order by sort_order, name;
select * from public.products order by created_at desc;
select * from public.product_images order by product_id, sort_order;
