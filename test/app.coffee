###
This file includes either the CoffeeScript or compiled JavaScript
version of the package depending on whether the COVERAGE environment
variable is set. The rest of the test source files include this file.
###
libPath = if process.env.COVERAGE then '../lib-cov' else '../lib'
module.exports = require(libPath)
