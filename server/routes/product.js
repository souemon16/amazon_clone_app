const express = require("express");
const productRouter = express.Router();
const auth_middleware = require("../middleware/auth_middleware");
const { Product } = require("../model/product");

productRouter.get("/api/products", auth_middleware ,async (req, res) => {
    try {
        const products = await Product.find({ category: req.query.category })
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
})

module.exports = productRouter;