-- Proyecto nuevo de Supabase: el servidor (service_role) no tenía permiso de ejecutar
-- las funciones creadas después de 002 (acreditación de pagos PayPhone, mensajes, etc.).
grant execute on all functions in schema public to service_role;
alter default privileges in schema public grant execute on functions to service_role;
