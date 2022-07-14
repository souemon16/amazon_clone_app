const express = require("express");
const userRouter = express.Router();

const auth_middleware = require("../middleware/auth_middleware");

const { Product } = require("../model/product");
const User = require("../model/user");

// ADD A PRODUCT 
userRouter.post("/user/add-to-cart", auth_middleware, async (req, res) => {
    try {
        const { id } = req.body;

        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.cart.length == 0){
            user.cart.push({ product, quantity: 1});
        } else {
            let isProductFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if(user.cart[i].product._id.equals(product.id)){
                    isProductFound = true
                }
            }
            if (isProductFound) {
                let producttt = user.cart.find((productt) => productt.product._id.equals(product._id));
                producttt.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1});
            }
        }

        user = await user.save();
        res.json(user);

        
    } catch (error) {
        res.status(500).json({ msg: error.message });
        console.log(error);
    }
});


// DELETE A PRODUCT 
userRouter.delete("/user/remove-from-cart/:id", auth_middleware, async (req, res) => {
    try {
        const { id } = req.params;

        const product = await Product.findById(id);
        let user = await User.findById(req.user);

            for (let i = 0; i < user.cart.length; i++) {
                if(user.cart[i].product._id.equals(product.id)){
                    if(user.cart[i].quantity == 1){
                        user.cart.splice(i, 1);
                    } else {
                        user.cart[i].quantity -= 1;
                    }
                }
            }
 
        user = await user.save();
        res.json(user);

        
    } catch (error) {
        res.status(500).json({ msg: error.message });
        console.log(error);
    }
});

module.exports = userRouter;