const { defineConfig } = require('cypress')

module.exports = defineConfig({
  viewportWidth: 1280,
  viewportHeight: 1600,
  defaultCommandTimeout: 10000,
  video: true,
  e2e: {
    setupNodeEvents(on) {
      on('task', { record(data) { console.log('LAB_RESULT ' + JSON.stringify(data)); return null } })
    },
  },
})
