bcrypt = require 'bcrypt'

module.exports =
  genSaltSync: bcrypt.genSaltSync
  hashSync: bcrypt.hashSync
  compareSync: bcrypt.compareSync
  getRounds: bcrypt.getRounds

  genSalt: (rounds, cb) ->
    if !cb
      cb = rounds
      rounds = 10
    d = process.domain
    bcrypt.genSalt rounds, (err, salt) ->
      if d
        return d.run () -> cb(err, salt)
      return cb(err, salt)

  hash: (data, salt, cb) ->
    d = process.domain
    bcrypt.hash data, salt, (err, encrypted) ->
      if d
        return d.run () -> cb(err, encrypted)
      return cb(err, encrypted)

  compare: (data, encrypted, cb) ->
    d = process.domain
    bcrypt.compare data, encrypted, (err, same) ->
      if d
        return d.run () -> cb(err, same)
      return cb(err, same)
