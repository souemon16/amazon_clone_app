const express = require("express");
const adminRouter = express.Router();

const admin_middleware = require("../middleware/admin_middleware");
const {Product} = require("../model/product");


// ADD A PRODUCT 
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
});

// SHOW PRODUCT FOR ADMIN 
adminRouter.get("/admin/get-product", admin_middleware,  async(req, res) => {
try {
    const products = await Product.find({});
    res.json(products);
} catch (e) {
    res.status(500).json({error: e.message});
}
});

// DELETE A PRODUCT 
adminRouter.post("/admin/delete-product", admin_middleware, async(req, res) => {
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id );
        res.json(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = adminRouter;
