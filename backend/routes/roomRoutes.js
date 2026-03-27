const express=require("express");
const router=express.Router();
const Room=require("../models/Room");

router.get("/",async(req,res)=>{
const rooms=await Room.find();
res.json(rooms);
});

router.post("/",async(req,res)=>{
const room=new Room(req.body);
const saved=await room.save();
res.json(saved);
});

module.exports=router;