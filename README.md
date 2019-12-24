# textcraft

A text-based sandbox mmo, or mud.

## Dependencies

Things you'll need to install:

- Node.js
- NPM (usually ships with Node)
- MongoDB

## Installation

1. Clone the repository.
```
% git clone https://norberg1@bitbucket.org/norberg1/textcraft-coffee.git
```

2. Install dependencies.
```
# From the top-level directory
% npm install -g coffee-script
% npm install
```

3. Seed the database
```
% mongo textcraft db/seed.js
```

## Configuration

There is a configuration file in the source code.

## Running

```
% npm start
```

## Playing

You play using telnet!
```
% telnet localhost 23232
```
The db is seeded with a single user called "test" with password "test".

## Commands

- You should be able to walk around using the cardinal directions, and up and down (n, e, s, w, ne, se, sw, nw, u, d). The shorthand and full words both work.
- You can name a room using the "name" command.
```
> name My Favorite Room
```
- You can describe a room using the "describe" command.
```
> describe You are in a dark room. You are likely to be eaten by a grue.
```
- You can look around by pressing enter (blank command) or using the "look" or "l" command.
- All of this would be terribly useless without the "dig" command. Dig allows you to dig out a new room in the cardinal direction of your choosing. A real coordinate system backs these rooms, so digging in a circle will indeed bring you back into the original room (cool!).
```
> dig e
> dig n
> dig w
> dig s
# Presto, back in the same room!
```
- Each room has a 3 dimensional coordinate. The cardinal directions correspond to directional vectors, so when you dig in a certain direction, the room at the calculated coordinate is either a) created if it does not exist, or b) given a new exit between the user's current room and the targeted one.
