const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

let posts = []; // In-memory storage for simplicity

// Create a post
app.post('/posts', (req, res) => {
  const { title, content } = req.body;
  if (!title || !content) {
    return res.status(400).json({ error: 'Title and content are required' });
  }
  const post = { id: posts.length + 1, title, content };
  posts.push(post);
  res.status(201).json({ message: 'Post created', post });
});

// Get all posts
app.get('/posts', (req, res) => {
  res.json(posts);
});

// Get a post by ID
app.get('/posts/:id', (req, res) => {
  const post = posts.find(p => p.id === parseInt(req.params.id));
  if (!post) {
    return res.status(404).json({ error: 'Post not found' });
  }
  res.json(post);
});

// Update a post
app.put('/posts/:id', (req, res) => {
  const post = posts.find(p => p.id === parseInt(req.params.id));
  if (!post) {
    return res.status(404).json({ error: 'Post not found' });
  }
  const { title, content } = req.body;
  if (title) post.title = title;
  if (content) post.content = content;
  res.json({ message: 'Post updated', post });
});

// Delete a post
app.delete('/posts/:id', (req, res) => {
  const index = posts.findIndex(p => p.id === parseInt(req.params.id));
  if (index === -1) {
    return res.status(404).json({ error: 'Post not found' });
  }
  posts.splice(index, 1);
  res.json({ message: 'Post deleted' });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
