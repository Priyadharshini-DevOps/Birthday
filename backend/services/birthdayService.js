const birthdayModel = require("../models/birthdayModel");

exports.getBirthdayWish = async () => {

    const data = await birthdayModel.fetchWish();

    return data;

};