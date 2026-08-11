# Límites gratuitos verificados · 11 de agosto de 2026

## Supabase Free

- Precio: USD 0/mes.
- 2 proyectos activos; los proyectos Free pueden pausarse después de una semana de inactividad.
- 500 MB de base de datos por proyecto.
- 1 GB de almacenamiento de archivos.
- 5 GB de transferencia y 5 GB de transferencia en caché.
- 50.000 usuarios activos mensuales.
- Límite de subida indicado por el plan: 50 MB; COMERCIAL RIBERA aplica un límite propio de 3 MB y optimiza las fotografías a WebP.
- Si se alcanzan límites: no se autoriza desde este proyecto ningún cambio de plan ni cobro. El propietario debe revisar el panel, optimizar/eliminar contenido o decidir voluntariamente si migra o amplía.
- Copias automáticas: no incluidas en Free; se incluye una consulta de exportación y se recomienda respaldo periódico.
- Fuente: https://supabase.com/pricing

## Cloudflare Pages Free

- 500 compilaciones al mes, una simultánea.
- 20 minutos máximo por compilación.
- 20.000 archivos por sitio.
- 25 MiB máximo por archivo estático.
- 100 proyectos por cuenta y hasta 100 dominios personalizados por proyecto.
- Si se alcanza la cuota de compilación: el sitio ya publicado continúa servido; se espera el reinicio de cuota o se elige voluntariamente otra forma de despliegue/plan.
- Fuente: https://developers.cloudflare.com/pages/platform/limits/

## GitHub Free

- Repositorios públicos y privados ilimitados para cuentas personales, con funciones privadas limitadas.
- 2.000 minutos mensuales de GitHub Actions para repositorios privados según la documentación del plan; el despliegue básico de Cloudflare no requiere usar Actions.
- El código se puede clonar, descargar y migrar en cualquier momento.
- Fuente: https://docs.github.com/es/get-started/learning-about-github/githubs-plans

## Cloudflare Workers Static Assets

- La configuración incluida publica `dist` y utiliza `not_found_handling: single-page-application`.
- Así, rutas como `/admin` y `/producto/...` reciben `index.html` sin incluir un archivo `_redirects`.
- Fuente: https://developers.cloudflare.com/workers/static-assets/routing/single-page-application/

Los proveedores pueden modificar sus planes. Confirma nuevamente las páginas oficiales antes de activar un servicio o aceptar cambios de facturación.
