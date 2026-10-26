export interface DestinationInfo {
  name: string;
  imageId: string;
  caption?: string;
}

export const NATIONAL_DESTINATIONS: DestinationInfo[] = [
  { name: "Barichara", imageId: "photo-1683688169514-9cabb6e23007", caption: "Pueblo colonial de piedra en Santander" },
  { name: "Barranquilla", imageId: "photo-1612381068436-7ebfddd382d0", caption: "Puerta de oro del Caribe" },
  { name: "Bogotá", imageId: "photo-1720067392108-89b9485aa090", caption: "La capital y el cerro de Monserrate" },
  { name: "Cali", imageId: "photo-1522812865094-5c856f116942", caption: "Capital mundial de la salsa" },
  { name: "Cartagena", imageId: "photo-1534943441045-1009d7cb0bb9", caption: "Ciudad amurallada frente al Caribe" },
  { name: "Guatapé", imageId: "photo-1539617546058-a8f9510b464e", caption: "Embalse, zócalos de colores y El Peñol" },
  { name: "Medellín", imageId: "photo-1548397968-8790c49522db", caption: "La ciudad de la eterna primavera" },
  { name: "Pereira", imageId: "photo-1639191646716-29807d648438", caption: "Corazón del Eje Cafetero" },
  { name: "San Andrés", imageId: "photo-1706219723970-31e41c804528", caption: "El mar de siete colores" },
  { name: "Santa Marta", imageId: "photo-1612815867823-85cf0957890b", caption: "Playas, Sierra Nevada y Tayrona" },
];

/**
 * Imágenes de inspiración para la invitación internacional. Son solo ejemplos
 * referenciales: la invitación da acceso a más de 130 destinos en el mundo.
 */
export const INTERNATIONAL_INSPIRATION: DestinationInfo[] = [
  { name: "Punta Cana", imageId: "photo-1692017827893-f97d95397b49" },
  { name: "Cancún", imageId: "photo-1679599767221-4e1128c941ee" },
  { name: "Orlando", imageId: "photo-1609184889233-eff6dd93def4" },
  { name: "París", imageId: "photo-1632168594270-831d770aa8c3" },
  { name: "Roma", imageId: "photo-1514896856000-91cb6de818e0" },
  { name: "Cusco", imageId: "photo-1587595431973-160d0d94add1" },
];

/** Fotos genéricas de hotel, siempre con la etiqueta "Imagen referencial". */
export const HOTEL_PHOTOS = [
  "photo-1520250497591-112f2f40a3f4",
  "photo-1566073771259-6a8506099945",
  "photo-1551882547-ff40c63fe5fa",
  "photo-1611892440504-42a792e24d32",
];

export function unsplashUrl(imageId: string, width = 400, height = 300): string {
  return `https://images.unsplash.com/${imageId}?w=${width}&h=${height}&fit=crop&auto=format&q=70`;
}
