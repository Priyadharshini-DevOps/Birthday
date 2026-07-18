require("dotenv").config();

const express = require("express");
const cors = require("cors");

const birthdayRoutes = require("./routes/birthdayRoutes");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api", birthdayRoutes);

app.get("/health", (req, res) => {
    res.status(200).json({
        status: "UP"
    });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Backend running on port ${PORT}`);
});