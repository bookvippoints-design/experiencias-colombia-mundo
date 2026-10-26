-- Experiencias Colombia y el Mundo — destinos nacionales (catálogo de hoteles de Colombia).
do $$
declare r record; d text; n text;
  col text := '''Barichara'',''Barranquilla'',''Bogotá'',''Cali'',''Cartagena'',''Guatapé'',''Medellín'',''Pereira'',''San Andrés'',''Santa Marta'')';
begin
  for r in
    select p.oid, pg_get_functiondef(p.oid) as def
    from pg_proc p join pg_namespace ns on ns.oid = p.pronamespace
    where ns.nspname = 'public' and p.prokind = 'f'
  loop
    d := r.def; n := d;
    n := replace(n, '''Quito'',''Guayaquil'',''Manta'',''Cuenca'',''Loja'',''Galápagos (Puerto Ayora)'')', col);
    n := replace(n, '''Quito'',''Guayaquil'',''Manta'',''Cuenca'',''Loja'')', col);
    if n <> d then execute n; end if;
  end loop;
end $$;

do $$
begin
  if exists (
    select 1 from pg_proc p join pg_namespace ns on ns.oid = p.pronamespace
    where ns.nspname = 'public' and p.prokind = 'f'
      and (pg_get_functiondef(p.oid) ~* 'guayaquil|ecuador|galápagos|''quito''|america/lima')
  ) then
    raise exception 'Quedan referencias de Ecuador en las funciones';
  end if;
end $$;

update public.products set conditions = 'Vigencia de 12 meses desde el pago aprobado para solicitar la escapada nacional y la invitación hotelera internacional.
Destinos nacionales: Barichara, Barranquilla, Bogotá, Cali, Cartagena, Guatapé, Medellín, Pereira, San Andrés y Santa Marta, en los hoteles del catálogo vigente, con desayuno.
Invitación hotelera internacional: más de 130 destinos, desde 4 días y 3 noches hasta 8 días y 7 noches según destino. Fee de emisión US$0 en este paquete. El viajero paga los impuestos gubernamentales y las tasas del hotel o resort, que varían por destino y temporada.
Una vez emitida, la invitación debe registrarse en 30 días; los impuestos y tasas se pagan dentro de 7 días tras el registro; desde la activación hay 18 meses para viajar.
Solo se puede usar una invitación internacional por año y no se puede repetir destino.'
where slug = 'escape-plus';

update public.products set conditions = 'Vigencia de 24 meses desde el pago aprobado para solicitar las escapadas nacionales y las invitaciones hoteleras internacionales.
Destinos nacionales: Barichara, Barranquilla, Bogotá, Cali, Cartagena, Guatapé, Medellín, Pereira, San Andrés y Santa Marta, en los hoteles del catálogo vigente, con desayuno.
Invitaciones hoteleras internacionales: más de 130 destinos, desde 4 días y 3 noches hasta 8 días y 7 noches según destino. Fee de emisión US$0 en este paquete. El viajero paga los impuestos gubernamentales y las tasas del hotel o resort.
Una invitación por año, sin repetir destino. Las dos invitaciones no pueden usarse en el mismo destino (no pueden viajar 4 personas al mismo destino). El incumplimiento de esta regla puede anular todos los certificados.
Desde la activación de cada invitación hay 18 meses para viajar.'
where slug = 'escape-premium';
