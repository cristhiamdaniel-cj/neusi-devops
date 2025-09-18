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
