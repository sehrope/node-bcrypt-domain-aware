bcrypt = require './app'
domain = require 'domain'
{assert, expect} = require 'chai'

describe 'generating a salt within a domain', () ->
  it 'should maintain the active domain when invoking the callback', (done) ->
    d = domain.create()
    d.run () ->
      bcrypt.genSalt 10, (err, salt) ->
        expect(err).to.be.not.ok
        expect(salt).to.be.ok
        activeDomain = process.domain
        expect(activeDomain).to.be.ok
        expect(activeDomain).to.be.equal(d)
        d.exit()
        done()

describe 'generating a hash within a domain', () ->
  it 'should maintain the active domain when invoking the callback', (done) ->
    d = domain.create()
    d.run () ->
      bcrypt.hash 'foobar', 10, (err, encrypted) ->
        expect(err).to.be.not.ok
        expect(encrypted).to.be.ok
        activeDomain = process.domain
        expect(activeDomain).to.be.ok
        expect(activeDomain).to.be.equal(d)
        d.exit()
        done()

describe 'comparing a password within a domain', () ->
  # Generate using sync methods for comparison:
  password = 'topsecret'
  notPassword = 'somethingelse'
  encrypted = bcrypt.hashSync password, 10

  it 'should maintain the active domain when invoking the callback when it matches', (done) ->
    d = domain.create()
    d.run () ->
      bcrypt.compare password, encrypted, (err, same) ->
        expect(err).to.be.not.ok
        expect(same).to.be.true
        activeDomain = process.domain
        expect(activeDomain).to.be.ok
        expect(activeDomain).to.be.equal(d)
        d.exit()
        done()

  it 'should maintain the active domain when invoking the callback when it does not match', (done) ->
    d = domain.create()
    d.run () ->
      bcrypt.compare notPassword, encrypted, (err, same) ->
        expect(err).to.be.not.ok
        expect(same).to.be.false
        activeDomain = process.domain
        expect(activeDomain).to.be.ok
        expect(activeDomain).to.be.equal(d)
        d.exit()
        done()
