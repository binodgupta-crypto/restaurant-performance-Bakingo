const express = require('express');
const app = express();
app.use(express.json());

let records = []; // in-memory demo

app.get('/api/records', (req,res)=> res.json(records));
app.post('/api/records', (req,res)=> { records.push(req.body); res.json({ok:true}); });

app.get('/', (req,res)=> res.send('Backend running'));

app.listen(4000, ()=> console.log('Backend on 4000'));
