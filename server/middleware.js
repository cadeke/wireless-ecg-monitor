const info = (req, next) => {
    console.log(`Route "${req.url}" was requested by "${req.header('x-forwarded-for') || req.connection.remoteAddress.substr(7)}"`);
    next();
}

module.exports = {info};