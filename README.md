# COMERCIAL RIBERA

Catálogo web profesional y administrable creado con React + Vite, Supabase y Cloudflare. El código es propio, portable y funciona sin servidor local ni mensualidad obligatoria.

## Funciones incluidas

- Inicio responsive y catálogo público.
- Búsqueda por nombre, marca, código, descripción, categoría y medida.
- Filtros por categoría, disponibilidad, oferta y unidad de venta.
- Productos destacados, ofertas, precio anterior y disponibilidad.
- Mangueras por metro, rollo, unidad y medida libre en pulgadas.
- Carrito local de cotización sin cuentas de cliente.
- Pedido/cotización por enlace directo de WhatsApp, sin API de pago.
- Panel `/admin` con Supabase Auth.
- Crear, editar y eliminar productos; precios, oferta, stock y publicación.
- Subida de fotografías a Supabase Storage; conversión WebP y reducción a 1600 px antes de subir.
- PostgreSQL con RLS: lectura pública únicamente de productos publicados y escritura exclusiva de administradores.
- Modo demostración cuando Supabase aún no está configurado.
- Cloudflare Pages y Workers Static Assets compatibles; no contiene `_redirects`.

## 1. Probar y compilar

Requiere Node.js 20 o superior.

```bash
npm install
cp .env.example .env
npm run dev
npm run build
```

La compilación queda en `dist/`. Nunca subas `.env` a GitHub.

## 2. Activar Supabase Free

1. Crea un proyecto en Supabase.
2. Abre **SQL Editor**, pega `supabase/schema.sql` y ejecútalo.
3. En **Authentication > Users**, crea el usuario administrador.
4. Regresa a SQL Editor y ejecuta, sustituyendo el correo:

```sql
insert into public.admin_users(user_id)
select id from auth.users where email = 'TU-CORREO';
```

5. Copia **Project URL** y la clave **Publishable/anon**. No copies `service_role` al frontend.
6. Configura:

```env
VITE_SUPABASE_URL=https://TU-PROYECTO.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=TU-CLAVE-PUBLICA
VITE_WHATSAPP_NUMBER=591TU_NUMERO
VITE_BUSINESS_ADDRESS=TU_DIRECCION
VITE_BUSINESS_HOURS=Lun–Sáb 08:00–18:30
```

## 3. Publicar en Cloudflare Pages

Conecta el repositorio GitHub y usa:

```text
Framework preset: Vite
Root directory: /
Build command: npm run build
Build output directory: dist
```

Agrega las variables `VITE_*` en **Settings > Environment variables** y vuelve a desplegar. No se requiere `wrangler` para Pages.

## 4. Publicar en Cloudflare Workers

El archivo `wrangler.jsonc` ya publica `dist` como SPA sin `_redirects`:

```text
Root directory: /
Build command: npm run build
Deploy command: npx wrangler deploy
```

## 5. Portabilidad

- Frontend: cualquier hosting estático compatible con Vite.
- Datos: tablas PostgreSQL exportables por SQL/CSV/`pg_dump`.
- Imágenes: URLs registradas en base de datos y archivos descargables desde Storage.
- WhatsApp: un enlace estándar; sin proveedor intermediario.
- Carrito: `localStorage` del navegador; no depende de un servicio externo.

Para migrar, exporta las tablas y el bucket `product-images`, cambia las variables `VITE_SUPABASE_*` y vuelve a compilar.

## 6. Seguridad

- La clave pública en el navegador no concede escritura por sí sola; RLS exige que `auth.uid()` esté en `admin_users`.
- La clave `service_role` jamás debe usarse en React ni guardarse en GitHub.
- El registro público no está implementado; los clientes no necesitan cuenta.
- Las imágenes se restringen a JPEG, PNG o WebP y 3 MB en Storage; el navegador las optimiza antes de subir.
- Antes de producción, cambia la contraseña del administrador por una única y fuerte.

## 7. Costos y límites

El proyecto no activa cobros automáticos ni requiere tarjeta desde el código. Los límites concretos de cada plan pueden cambiar; verifica las páginas oficiales enlazadas en `docs/SERVICIOS_EXTERNOS.md` antes de configurar cuentas.

Supabase conectado correctamente.
