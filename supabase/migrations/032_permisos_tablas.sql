-- Proyectos nuevos de Supabase no dan permisos por defecto en las tablas.
-- Se replica lo que tienen Ecuador y Perú: el servidor (service_role) con acceso total
-- y los usuarios conectados solo lectura (filtrada por RLS). anon sin acceso.
grant usage on schema public to service_role, authenticated;
grant all on all tables in schema public to service_role;
grant all on all sequences in schema public to service_role;
grant select on all tables in schema public to authenticated;
revoke all on all tables in schema public from anon;
alter default privileges in schema public grant all on tables to service_role;
alter default privileges in schema public grant all on sequences to service_role;
alter default privileges in schema public grant select on tables to authenticated;
