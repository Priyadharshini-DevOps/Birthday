const birthdayService = require("../services/birthdayService");

exports.getBirthdayWish = async (req, res) => {

    try {

        const data = await birthdayService.getBirthdayWish();

        res.json(data);

    } catch (err) {

        res.status(500).json({

            message: err.message

        });

    }

};