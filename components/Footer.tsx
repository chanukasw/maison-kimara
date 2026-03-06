import Link from 'next/link';

export default function Footer() {
  const year = new Date().getFullYear();

  return (
    <footer className="border-t border-gray-200 bg-gray-50 py-12">
      <div className="max-w-7xl mx-auto px-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
          <div>
            <h3 className="font-light text-lg mb-4">MAISON KIMARA</h3>
            <p className="text-sm text-gray-600">Premium clothing for everyone</p>
          </div>
          <div>
            <h4 className="font-light mb-4">Shop</h4>
            <ul className="space-y-2 text-sm">
              <li><Link href="/products?category=women" className="text-gray-600 hover:text-black">Women</Link></li>
              <li><Link href="/products?category=men" className="text-gray-600 hover:text-black">Men</Link></li>
              <li><Link href="/products?category=kids" className="text-gray-600 hover:text-black">Kids</Link></li>
            </ul>
          </div>
          <div>
            <h4 className="font-light mb-4">Help</h4>
            <ul className="space-y-2 text-sm">
              <li><Link href="/contact" className="text-gray-600 hover:text-black">Contact</Link></li>
              <li><Link href="/faq" className="text-gray-600 hover:text-black">FAQ</Link></li>
            </ul>
          </div>
          <div>
            <h4 className="font-light mb-4">Legal</h4>
            <ul className="space-y-2 text-sm">
              <li><Link href="/privacy" className="text-gray-600 hover:text-black">Privacy</Link></li>
              <li><Link href="/terms" className="text-gray-600 hover:text-black">Terms</Link></li>
            </ul>
          </div>
        </div>
        <div className="border-t border-gray-200 pt-8 text-center text-sm text-gray-600">
          <p>&copy; {year} MAISON KIMARA. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
}
