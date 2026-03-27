const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const studentRoutes = require("./routes/studentRoutes");

const app = express();
app.use(cors()); // ✅ Crucial for deployment
app.use(express.json());

// ✅ Use MongoDB Atlas link from your environment variables
const MONGO_URI = process.env.MONGODB_URI || "mongodb://127.0.0.1:27017/hostelDB";

mongoose.connect(MONGO_URI)
  .then(() => console.log("MongoDB Connected Successfully"))
  .catch(err => console.log("DB Connection Error:", err));

app.use("/api/students", studentRoutes);

// ✅ Render will provide a dynamic PORT
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});