const jwt = require("jsonwebtoken");

// SETTING UP MIDDLEWARE TO ACCESS THE VERIFIED TOKEN USER 
const auth_middleware = (req, res, next) => {
try {
    // GET THE TOKEN FROM HEADER 
    const token = req.header("x-auth-token");
    if(!token)  return res.status(401).json({ msg: "No auth token, access denied! "});

    // IF TOKEN FOUND VERIFY IT 
    const verifiedToken = jwt.verify(token, "passwordkey");
    if(!verifiedToken) return res.status(401).json({ msg: "Token Verification failed! "});

    req.user = verifiedToken.id; 
    req.token = token;
    next();
} catch (err) {
    res.status(500).json({ error: err.message });   
}
}

module.exports = auth_middleware;