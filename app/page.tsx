import Hero from '@/components/Hero';
import ProductGrid from '@/components/ProductGrid';

export default function Home() {
  return (
    <>
      <Hero />
      <section className="px-6 py-16 max-w-7xl mx-auto">
        <h2 className="text-4xl font-light mb-12">Featured Collections</h2>
        <ProductGrid />
      </section>
    </>
  );
}
