const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors()); 
app.use(express.json());

// Database Connection
const mongoURI = process.env.MONGODB_URI;

mongoose.connect(mongoURI)
  .then(() => console.log('✅ MongoDB Connected to HostelProDB'))
  .catch(err => {
    console.error('❌ DB Connection Error:', err.message);
  });

// Routes
app.use('/api/students', require('./routes/studentRoutes'));
app.use('/api/rooms', require('./routes/roomRoutes'));

// Port - Defaults to 10000 for Render
const PORT = process.env.PORT || 10000;
app.listen(PORT, () => {
  console.log(`🚀 HostelPro Backend running on port ${PORT}`);
});