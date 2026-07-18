const db = require("../config/db");

exports.fetchWish = async () => {

    const [rows] = await db.execute(
        "SELECT name, message FROM birthday_messages LIMIT 1"
    );

    return rows[0];

};