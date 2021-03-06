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

productRouter.get("/api/products/search/:name", auth_middleware, async (req, res) => {
    try {
        const products = await Product.find({ 
            name: { $regex: req.params.name, $options: "i" }
         })
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message })
    }
});

productRouter.post("/api/rate-product", auth_middleware, async (req, res) => {
    try {
        const {id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId == req.user) {
                product.ratings.splice( i, 1);
                break;
            }          
        }

        const ratingSchema =  {
            userId: req.user,
            rating
        }

         product.ratings.push(ratingSchema);
         product = await product.save();
         res.json(product);
         
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

// DEAL OF THE DAY 
productRouter.get("/api/deal-of-the-day", auth_middleware, async(req, res) => {
    try {
        let products = await Product.find({});

        products = products.sort((product1, product2) => {
            let product1Sum = 0;
            let product2Sum = 0;

            for (let i = 0; i < product1.ratings.length; i++) {
                product1Sum += product1.ratings[i].rating 
            };

            for (let i = 0; i < product2.ratings.length; i++) {
                product2Sum += product2.ratings[i].rating 
            }

            return product1Sum < product2Sum ? 1 : -1; 
        })

        res.json(products[0]);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;