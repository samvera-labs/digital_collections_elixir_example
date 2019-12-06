const path = require("path")

module.exports = {
  rootDir: path.resolve(__dirname, "../../"),
  modulePaths: ["<rootDir>"],
  moduleFileExtensions: ["js", "json", "vue"],
  moduleNameMapper: {
    "^@/(.*)$": "<rootDir>/js/$1",
  },
  transform: {
    "^.+\\.js$": "<rootDir>/node_modules/babel-jest",
    ".*\\.(vue)$": "<rootDir>/node_modules/vue-jest",
  },
  coverageDirectory: "<rootDir>/js/test/unit/coverage",
  collectCoverageFrom: [
    "<rootDir>/js/components/**/*.{js,vue}",
    "!<rootDir>/js/components/_components.js",
    "!<rootDir>/js/components/_lux-elements-used.js",
    "!<rootDir>/node_modules/**",
  ]
}
