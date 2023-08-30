//Imports from packages
const express = require('express');
const mongoose = require('mongoose');

//import from files
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

//init
const PORT = process.env.PORT||3000;
const app = express();
const DB = "mongodb+srv://altamashalam19:<password>@cluster0.atnjhxe.mongodb.net/?retryWrites=true&w=majority";
//middleware
//client -> middleware -> Server ->client 
app.use(express.json()); 
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//connections
mongoose.connect(DB).then(()=>{ 
  console.log("connection successful");
}).catch(e=>{console.log(e)});

app.listen(PORT,"0.0.0.0",()=>{
  console.log(`Connected at port ${PORT}`);
})
