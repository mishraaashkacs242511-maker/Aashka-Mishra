const mongoose=require("mongoose");

const RoomSchema=new mongoose.Schema({

roomNumber:String,
capacity:Number,
occupied:Number

});

module.exports=mongoose.model("Room",RoomSchema);