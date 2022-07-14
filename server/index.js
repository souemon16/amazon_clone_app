// IMPORT FROM PACKAGES 
const express = require("express");
const mongoose = require("mongoose");

// IMPORT FROM OTHER FILES 
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// INIT 
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://souemon:amazonclone@cluster0.ifklh.mongodb.net/?retryWrites=true&w=majority";

// MIDDLEWARE 
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// DATABASE CONNECTIONS 
mongoose.connect(DB).then(() => {
    console.log("connection succesfully");
}).catch((e) => {
    console.log(e);
})



app.listen(PORT, 0,0,0,0, () => {
    console.log(`Connected to PORT ${PORT}`)
})