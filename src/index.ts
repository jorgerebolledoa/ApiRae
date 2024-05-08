import express from 'express';
import raeRoutes from './routes/rae';

const app = express();
const PORT = 3000;

app.use(express.json());
app.use('/api', raeRoutes);

app.get('/', (_req, res) => {
  res.send('Hello World!');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});