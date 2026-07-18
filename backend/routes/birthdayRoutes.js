const express = require("express");

const router = express.Router();

const birthdayController = require("../controllers/birthdayController");

router.get("/birthday", birthdayController.getBirthdayWish);

module.exports = router;