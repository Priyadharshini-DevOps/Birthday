const test = require('node:test');
const assert = require('node:assert/strict');

const db = require('../config/db');
const birthdayModel = require('../models/birthdayModel');

test('returns a fallback birthday wish when the database query fails', async () => {
  db.execute = async () => {
    throw new Error('db unavailable');
  };

  const result = await birthdayModel.fetchWish();

  assert.deepStrictEqual(result, {
    name: 'Friend',
    message: 'Happy Birthday! 🎉'
  });
});
