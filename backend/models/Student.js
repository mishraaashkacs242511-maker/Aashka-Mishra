const mongoose = require("mongoose");

const StudentSchema = new mongoose.Schema({

name:String,
email:String,
phone:String,
course:String,
roomNumber:String,
feeStatus:String

});

module.exports = mongoose.model("Student",StudentSchema);