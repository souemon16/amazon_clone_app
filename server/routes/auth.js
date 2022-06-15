const express = require("express");
const User = require("../model/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

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

module.exports = authRouter;