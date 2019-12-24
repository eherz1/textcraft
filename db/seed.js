// Seed file for database

db.rooms.drop();
db.users.drop();

db.rooms.insert({
  _id: ObjectId("54bde612fd398309c1847f48"),
  name: 'Origin',
  description: '',
  coordinates: {
    x: 0,
    y: 0,
    z: 0
  },
  characters: [],
  exits: []
});

db.users.insert({
  login: 'test',
  password: 'test'
});

