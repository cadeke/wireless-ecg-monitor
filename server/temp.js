"use strict";
import express from "express";
const app = express();

// Middleware
// const {info} = require("./middleware");
// app.use(info); 

// CORS
import cors from "cors";
app.use(cors(
));

app.get("/", (req, res)=>{
    console.log("Requested:", req.url);

    var data = {
        "time": 1001034,
        "voltage": 0.58382,
        "bpm": 81,
        "healty": true
    }
    res.send(data); // determine content-type automatically
})

app.listen(3000, (err)=>{
    if(err){
        console.log("There was an error", err);
        return;
    }
    console.log("Server running on http://127.0.0.1:3000"); // change to 192.168.0.188:3000 for RPI
})