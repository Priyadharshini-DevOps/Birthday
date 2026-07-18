const db = require("../config/db");

exports.fetchWish = async () => {

    try {
        const [rows] = await db.execute(
            "SELECT name, message FROM birthday_messages LIMIT 1"
        );

        return rows[0] || {
            name: "Friend",
            message: "Happy Birthday! 🎉"
        };
    } catch (error) {
        console.error("Database query failed, using fallback message:", error.message);

        return {
            name: "Friend",
            message: "Happy Birthday! 🎉"
        };
    }

};