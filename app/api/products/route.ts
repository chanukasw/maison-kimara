const express = require('express');
const router = express.Router();

// Mock product data
const products = [
    { id: 1, name: 'Product 1', price: 9.99, image: 'https://example.com/image1.jpg' },
    { id: 2, name: 'Product 2', price: 14.99, image: 'https://example.com/image2.jpg' },
    { id: 3, name: 'Product 3', price: 7.99, image: 'https://example.com/image3.jpg' },
    { id: 4, name: 'Product 4', price: 19.99, image: 'https://example.com/image4.jpg' },
    { id: 5, name: 'Product 5', price: 29.99, image: 'https://example.com/image5.jpg' },
    { id: 6, name: 'Product 6', price: 12.99, image: 'https://example.com/image6.jpg' },
    { id: 7, name: 'Product 7', price: 22.99, image: 'https://example.com/image7.jpg' },
    { id: 8, name: 'Product 8', price: 34.99, image: 'https://example.com/image8.jpg' }
];

// GET /api/products
router.get('/', (req, res) => {
    res.json({ items: products });
});

module.exports = router;