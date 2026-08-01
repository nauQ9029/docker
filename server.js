const express = require('express');
const mongoose = require('mongoose');

const app = express();
app.use(express.json());

// Configuration variables from Environment
const PORT = process.env.PORT || 3000;
const DB_HOST = process.env.DB_HOST || 'localhost';
const DB_PORT = process.env.DB_PORT || 27017;
const DB_NAME = process.env.DB_NAME || 'tododb';

// MongoDB connection string
const MONGO_URI = `mongodb://${DB_HOST}:${DB_PORT}/${DB_NAME}`;

// Define a database schema (Data Structure)
const TodoSchema = new mongoose.Schema({
  text: String,
  completed: { type: Boolean, default: false }
});

const Todo = mongoose.model('Todo', TodoSchema);

// Endpoint 1: Get all todos
app.get('/todos', async (req, res) => {
  try {
    const todos = await Todo.find();
    res.json(todos);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint 2: Add a new todo
app.post('/todos', async (req, res) => {
  try {
    const newTodo = new Todo({ text: req.body.text });
    await newTodo.save();
    res.status(201).json(newTodo);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Connect to MongoDB and start server
mongoose.connect(MONGO_URI)
  .then(() => {
    console.log(`Connected to MongoDB at ${DB_HOST}:${DB_PORT}`);
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
  })
  .catch((err) => console.error('MongoDB connection error:', err));