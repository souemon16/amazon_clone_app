const jwt = require("jsonwebtoken");
const User = require("../model/user");

const admin_middleware = async(req, res, next) => {
    try {
        // GET THE TOKEN FROM HEADER 
        const token = req.header('x-auth-token');
        if(!token) return res.status(401).json({ msg: "No token found. Access denied!" });

        // IF THE TOKEN FOUND VERIFY IT 
        const verifiedToken = jwt.verify(token, "passwordKey");
        if(!verifiedToken) return res.status(401).json({ msg: "Token verification failed"});

        const user = await User.findById(verifiedToken.id);
        if(user.type == 'user' || user.type == 'admin'){
            return res.status(401).json({ msg: "You are not a admin!" });
        }

        req.user = verifiedToken.id;
        req.token = token;
        next(); 
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

module.exports = admin_middleware;