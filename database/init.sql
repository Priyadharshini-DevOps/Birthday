CREATE DATABASE IF NOT EXISTS birthdaydb;

USE birthdaydb;

CREATE TABLE IF NOT EXISTS birthday_messages (

    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    message TEXT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

INSERT INTO birthday_messages (name, message)
VALUES
(
'My Love',

'Happy Birthday! 🎉

May this year bring you endless happiness, good health, success, and beautiful memories. Every day with you is a gift, and today we celebrate the wonderful person you are. Wishing you a birthday filled with love, laughter, and everything you''ve dreamed of. ❤️'
);