bcrypt = require './app'
domain = require 'domain'
{assert, expect} = require 'chai'

describe 'generating a salt without a domain', () ->
  it 'should have no active domain when invoking the callback', (done) ->
    bcrypt.genSalt 10, (err, salt) ->
      expect(err).to.be.not.ok
      expect(salt).to.be.ok
      expect(process.domain).to.be.not.ok
      done()

describe 'generating a hash without a domain', () ->
  it 'should have no active domain when invoking the callback', (done) ->
    bcrypt.hash 'foobar', 10, (err, encrypted) ->
      expect(err).to.be.not.ok
      expect(encrypted).to.be.ok
      expect(process.domain).to.be.not.ok
      done()

describe 'comparing a password without a domain', () ->
  # Generate using sync methods for comparison:
  password = 'topsecret'
  notPassword = 'somethingelse'
  encrypted = bcrypt.hashSync password, 10

  it 'should have no active domain when invoking the callback when it matches', (done) ->
    bcrypt.compare password, encrypted, (err, same) ->
      expect(err).to.be.not.ok
      expect(same).to.be.true
      expect(process.domain).to.be.not.ok
      done()

  it 'should have no active domain when invoking the callback when it does not match', (done) ->
    bcrypt.compare notPassword, encrypted, (err, same) ->
      expect(err).to.be.not.ok
      expect(same).to.be.false
      expect(process.domain).to.be.not.ok
      done()
