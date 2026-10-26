-- Experiencias Colombia y el Mundo — adaptación (parte 1): zona horaria America/Bogota,
-- nombre de la plataforma y paquetes (solo Escape Plus 12 meses y Escape Premium 24 meses).
-- Los destinos nacionales de Colombia van en 031_colombia_destinos.sql.
do $$
declare r record; d text; n text;
begin
  for r in
    select p.oid, pg_get_functiondef(p.oid) as def
    from pg_proc p join pg_namespace ns on ns.oid = p.pronamespace
    where ns.nspname = 'public' and p.prokind = 'f'
  loop
    d := r.def; n := d;
    n := replace(n, 'America/Guayaquil', 'America/Bogota');
    n := replace(n, 'Experiencias Ecuador y el Mundo', 'Experiencias Colombia y el Mundo');
    n := replace(n, ' y recibir puntos de regalo', '');
    if n <> d then execute n; end if;
  end loop;
end $$;

update public.products set active = false, purchasable = false where slug = 'escape-esencial';

update public.products set
  tagline = 'Colombia y el mundo en un solo paquete',
  description = 'Una escapada nacional de 3 días y 2 noches para 2 personas con desayuno y una invitación hotelera internacional con fee de emisión US$0.',
  price = 199.00, purchasable = true, active = true, validity_months = 12,
  national_count = 1, national_days = 3, national_nights = 2, national_people = 2, breakfast_included = true,
  international_count = 1, points = 0, bonus_points = 0, highlight = 'Más elegido', sort = 1
where slug = 'escape-plus';

update public.products set
  tagline = 'El doble de experiencias para disfrutar y regalar',
  description = 'Dos escapadas nacionales de 3 días y 2 noches para 2 personas con desayuno y dos invitaciones hoteleras internacionales con fee de emisión US$0.',
  price = 398.00, purchasable = true, active = true, validity_months = 24,
  national_count = 2, national_days = 3, national_nights = 2, national_people = 2, breakfast_included = true,
  international_count = 2, points = 0, bonus_points = 0, highlight = 'Más experiencias', sort = 2
where slug = 'escape-premium';

update public.products set active = false where category = 'points';
