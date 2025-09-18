#!/bin/bash
# ===========================================
# 🚀 Script para crear frontend NEUSI DevOps con Next.js + Tailwind (Next 13+)
# ===========================================

cd "$(dirname "$0")" || exit 1

# Crear carpeta frontend
echo "=== Creando carpeta frontend ==="
mkdir -p frontend
cd frontend

# Inicializar proyecto Next.js (usa app dir por defecto en v13+)
echo "=== Inicializando proyecto Next.js ==="
npx create-next-app@latest . --typescript --eslint --use-npm --yes

# Instalar Tailwind CSS
echo "=== Instalando Tailwind CSS ==="
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Configuración básica de Tailwind
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# Estilos globales (Next.js 13+ usa app/globals.css)
cat > app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply bg-gray-100 text-gray-900;
}
EOF

# Página inicial conectada al backend NEUSI DevOps (usa app/page.tsx)
cat > app/page.tsx << 'EOF'
"use client";
import { useEffect, useState } from "react";

export default function Home() {
  const [proyectos, setProyectos] = useState([]);

  useEffect(() => {
    fetch("https://devops-neusi.ngrok.io/api/proyectos/")
      .then((res) => res.json())
      .then((data) => setProyectos(data))
      .catch((err) => console.error("Error cargando proyectos:", err));
  }, []);

  return (
    <div className="min-h-screen flex flex-col items-center justify-center p-6">
      <h1 className="text-4xl font-bold mb-6 text-blue-600">🚀 NEUSI DevOps</h1>
      <h2 className="text-xl mb-4">Proyectos registrados</h2>
      <ul className="space-y-3 w-full max-w-lg">
        {proyectos.map((p: any) => (
          <li key={p.id} className="bg-white shadow p-4 rounded-md">
            <h3 className="font-semibold text-lg">{p.nombre}</h3>
            <p className="text-sm text-gray-600">{p.descripcion}</p>
            <span className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded">
              {p.estado}
            </span>
          </li>
        ))}
      </ul>
    </div>
  );
}
EOF

echo "✅ Frontend Next.js creado con éxito en /frontend"
echo "Para iniciarlo en el puerto 8077:"
echo "cd frontend && npm run dev -- -p 8077"
echo ""
echo "📡 Luego crea el túnel ngrok:"
echo "ngrok http --domain=neusi-frontend.ngrok.io 8077"
