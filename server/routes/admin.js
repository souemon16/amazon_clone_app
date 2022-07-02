const express = require("express");
const adminRouter = express.Router();

const admin_middleware = require("../middleware/admin_middleware");
const {Product} = require("../model/product");

adminRouter.post("/admin/add-product", admin_middleware, async (req, res) => {
    try {
        const { name, description, quantity, price, category, images } = req.body;

        let product = new Product({
            name,
            description,
            quantity,
            price,
            category,
            images
        });

        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({ msg: error.message });
        console.log(error);
    }
})

module.exports = adminRouter;
