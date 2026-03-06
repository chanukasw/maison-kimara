'use client';

import { useEffect, useState } from 'react';

interface Product {
  id: string;
  name: string;
  price: number;
  image: string;
}

export default function ProductGrid() {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_ENDPOINT}/api/products?limit=8`
        );
        if (!response.ok) throw new Error('Failed to fetch');
        const data = await response.json();
        setProducts(data.items || []);
      } catch (error) {
        console.error('Error:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  if (loading) return <div className="text-center py-12">Loading...</div>;

  if (products.length === 0) {
    return <div className="text-center py-12 text-gray-500">No products yet</div>;
  }

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      {products.map((product) => (
        <div key={product.id} className="group">
          <div className="bg-gray-100 aspect-square mb-4 overflow-hidden rounded">
            <img
              src={product.image}
              alt={product.name}
              className="w-full h-full object-cover group-hover:scale-105 transition"
            />
          </div>
          <h3 className="font-light text-lg">{product.name}</h3>
          <p className="text-gray-600">${product.price}</p>
        </div>
      ))}
    </div>
  );
}
