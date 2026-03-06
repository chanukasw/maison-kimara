export default function Hero() {
  return (
    <section className="h-screen bg-gradient-to-r from-gray-100 to-gray-50 flex items-center">
      <div className="max-w-7xl mx-auto px-6">
        <h1 className="text-6xl md:text-7xl font-light tracking-wider mb-6">
          MAISON<br />KIMARA
        </h1>
        <p className="text-lg md:text-2xl font-light text-gray-600 mb-8">
          Premium clothing for the modern individual
        </p>
        <div className="flex gap-4">
          <button className="px-8 py-3 bg-black text-white hover:bg-gray-800 transition">
            Shop Now
          </button>
          <button className="px-8 py-3 border border-black hover:bg-black hover:text-white transition">
            Learn More
          </button>
        </div>
      </div>
    </section>
  );
}
