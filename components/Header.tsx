'use client';

import Link from 'next/link';
import { useState } from 'react';
import { useAuthStore } from '@/lib/store/auth';

export default function Header() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { user, logout } = useAuthStore();

  return (
    <header className="border-b border-gray-200 sticky top-0 bg-white z-50">
      <nav className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
        <Link href="/" className="text-lg font-light tracking-wider">
          MAISON KIMARA
        </Link>

        <div className="hidden md:flex items-center space-x-8">
          <Link href="/products?category=women" className="hover:text-gray-600">WOMEN</Link>
          <Link href="/products?category=men" className="hover:text-gray-600">MEN</Link>
          <Link href="/products?category=kids" className="hover:text-gray-600">KIDS</Link>
        </div>

        <div className="flex items-center space-x-6">
          <Link href="/search">🔍</Link>
          <Link href="/cart">🛒</Link>
          {user ? (
            <button onClick={() => logout()}>Logout</button>
          ) : (
            <Link href="/auth/login">Login</Link>
          )}
        </div>

        <button className="md:hidden" onClick={() => setMobileMenuOpen(!mobileMenuOpen)}>
          ☰
        </button>
      </nav>

      {mobileMenuOpen && (
        <div className="md:hidden border-t border-gray-200 px-6 py-4 space-y-4">
          <Link href="/products?category=women" className="block">WOMEN</Link>
          <Link href="/products?category=men" className="block">MEN</Link>
          <Link href="/products?category=kids" className="block">KIDS</Link>
        </div>
      )}
    </header>
  );
}
