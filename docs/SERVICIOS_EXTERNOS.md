# Servicios externos evaluados

Fecha de revisión: 11 de agosto de 2026. Los límites de planes pueden cambiar; se deben confirmar en las páginas oficiales antes de crear o modificar una cuenta.

## GitHub Free

- Uso: repositorio Git y propiedad del código.
- Gratis: repositorios públicos y privados; funciones básicas de colaboración.
- Al superar límites: ciertas funciones o consumo adicional pueden requerir ajuste o pago; el código se puede clonar en cualquier momento.
- Tarjeta: no es necesaria para crear un repositorio Free.
- Alternativa: GitLab Free, Codeberg o repositorio Git local/remoto propio.
- Portabilidad: completa mediante `git clone --mirror`.
- Dependencia: baja.

## Cloudflare Pages / Workers Free

- Uso: servir la aplicación React compilada en Internet sin usar la PC del propietario.
- Gratis: alojamiento estático y despliegues dentro de las cuotas vigentes del plan Free.
- Al superar límites: Cloudflare puede bloquear o limitar nuevos despliegues/uso hasta reinicio de cuota o cambio voluntario de plan; este proyecto no activa un plan de pago.
- Tarjeta: normalmente no se necesita para Pages Free; confirma durante el alta.
- Alternativa: GitHub Pages, Netlify Free o servidor estático propio.
- Portabilidad: completa; basta publicar la carpeta `dist`.
- Dependencia: baja. `wrangler.jsonc` solo es un adaptador opcional.

## Supabase Free

- Uso: PostgreSQL, autenticación administrativa y almacenamiento de imágenes.
- Gratis: una cuota limitada de base de datos, usuarios, almacenamiento y transferencia según el plan vigente.
- Al superar límites: el servicio puede restringir recursos, pausar el proyecto o pedir cambio voluntario de plan; no se autoriza ningún upgrade automático desde este proyecto.
- Tarjeta: consulta el alta actual; el proyecto no almacena datos bancarios.
- Alternativa: PostgreSQL + Auth.js/Keycloak + almacenamiento S3 compatible o servidor propio. Para una migración rápida, Neon Free puede alojar PostgreSQL, pero Auth/Storage tendrían que sustituirse.
- Portabilidad: datos exportables por PostgreSQL/CSV y archivos descargables.
- Dependencia: media en Auth/Storage; baja en la base de datos por usar PostgreSQL estándar.

## WhatsApp directo (`wa.me`)

- Uso: abrir una conversación con un mensaje preparado por el cliente.
- Gratis: no utiliza WhatsApp Business API ni intermediarios.
- Limitaciones: no automatiza respuestas, pagos, seguimiento ni envío sin intervención del cliente.
- Al superar límites: no existe una cuota de API en esta integración; se aplican los términos normales de WhatsApp.
- Alternativa: enlace `tel:` o formulario de contacto alojado por cuenta propia.
- Portabilidad: completa; el número se cambia con una variable de entorno.
- Dependencia: baja.

## Google Fonts

- Uso: tipografías visuales Barlow Condensed e Inter.
- Gratis: carga web pública.
- Limitaciones: requiere conexión al dominio de fuentes; si falla, se usan tipografías del sistema.
- Alternativa completamente gratuita: descargar y alojar localmente las fuentes open source o utilizar solo fuentes del sistema.
- Portabilidad: completa.

## Fuentes oficiales que deben verificarse

- Supabase Pricing: https://supabase.com/pricing
- Supabase Auth RLS: https://supabase.com/docs/guides/database/postgres/row-level-security
- Supabase Storage access control: https://supabase.com/docs/guides/storage/security/access-control
- Cloudflare Pages limits: https://developers.cloudflare.com/pages/platform/limits/
- Cloudflare Workers Static Assets: https://developers.cloudflare.com/workers/static-assets/
- GitHub Plans: https://github.com/pricing
