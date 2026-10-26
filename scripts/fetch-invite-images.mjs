// Descarga, durante el build, las fotos de destinos de la invitación impresa
// para que el PDF no dependa de internet al generarse. Si alguna falla, el
// build sigue y el PDF intenta descargarla al momento.
import { mkdir, writeFile, stat } from "node:fs/promises";
import path from "node:path";

const IMAGES = {
  barichara: "photo-1683688169514-9cabb6e23007",
  barranquilla: "photo-1612381068436-7ebfddd382d0",
  bogota: "photo-1720067392108-89b9485aa090",
  cali: "photo-1522812865094-5c856f116942",
  cartagena: "photo-1534943441045-1009d7cb0bb9",
  guatape: "photo-1539617546058-a8f9510b464e",
  medellin: "photo-1548397968-8790c49522db",
  pereira: "photo-1639191646716-29807d648438",
  "san-andres": "photo-1706219723970-31e41c804528",
  "santa-marta": "photo-1612815867823-85cf0957890b",
  "punta-cana": "photo-1692017827893-f97d95397b49",
  cancun: "photo-1679599767221-4e1128c941ee",
  orlando: "photo-1609184889233-eff6dd93def4",
  paris: "photo-1632168594270-831d770aa8c3",
  roma: "photo-1514896856000-91cb6de818e0",
};

const dir = path.join(process.cwd(), "public", "invitacion", "dest");
await mkdir(dir, { recursive: true });
let ok = 0;
await Promise.all(
  Object.entries(IMAGES).map(async ([slug, id]) => {
    const file = path.join(dir, `${slug}.jpg`);
    try {
      const existing = await stat(file).catch(() => null);
      if (existing && existing.size > 5000) { ok++; return; }
      const res = await fetch(`https://images.unsplash.com/${id}?w=480&h=320&fit=crop&fm=jpg&q=75`, { signal: AbortSignal.timeout(15000) });
      const type = res.headers.get("content-type") ?? "";
      const buf = Buffer.from(await res.arrayBuffer());
      if (!res.ok || !type.startsWith("image/") || buf.length < 5000) throw new Error(`${res.status} ${type}`);
      await writeFile(file, buf);
      ok++;
    } catch (e) {
      console.warn(`[invitacion] no se pudo descargar ${slug}: ${e instanceof Error ? e.message : e}`);
    }
  })
);
console.log(`[invitacion] fotos de destinos listas: ${ok}/${Object.keys(IMAGES).length}`);
