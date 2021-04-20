const info = (req, res, next) => {
    console.log("Request IP: ", req.method);
    next();
}

module.exports = {info};