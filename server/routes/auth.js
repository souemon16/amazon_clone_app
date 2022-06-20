const express = require("express");
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth_middleware = require("../middleware/auth_middleware");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
    const {name, email, password} = req.body;
    const existingUser = await User.findOne({ email });
    if(existingUser){
        return res.status(400).json({
            msg: "User with same email address already exists!"
        })
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
        name, email, password : hashedPassword
    });

    user = await user.save();
    res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

authRouter.post("/api/signin", async (req, res) => {
   try {
    const { email, password } = req.body;
    const signinUser = await User.findOne({email});
    if(!signinUser){
        res.status(400).json({ msg: "User with this email address does not exist! "})
    }
    const isMatch = await bcryptjs.compare(password, signinUser.password);
    if(!isMatch){
        res.status(400).json({ msg: "Invalid Credentials "})
    }
    const token = jwt.sign({ id: signinUser._id}, "passwordkey");
    res.json({ token, ...signinUser._doc })
   } catch (error) {
    res.status(500).json({ error: e.message })
   }
})

// TOKEN VALIDATION 
authRouter.post("/istokenvalid", async(req, res) => {
     try {
        // GET TOKEN VIA HEADER 
        const token = req.header("x-auth-token");
        // IF NO TOKEN PASSED THEN -
        if(!token) return res.json(false);

        // IF TOKEN FOUND THEN VERIFY IT 
        const verifiedToken = jwt.verify(token, "passwordkey");
        // IF TOKEN ISNT VERIFIED 
        if(!verifiedToken) return res.json(false);

        // IF VERIFIEDTOKEN FOUND THEN CHECK FOR USER 
        const user = User.findById(verifiedToken.id);
        // IF USER DOES NOT EXIST 
        if(!user) return res.json(false);

        // IF THERE ARE NO FALSE THEN 
        res.json(true);

     } catch (e) {
        res.status(500).json({ error: e.message });
     }
})

// GET USER DATA API
 authRouter.get("/", auth_middleware, async(req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token });
 })


module.exports = authRouter;