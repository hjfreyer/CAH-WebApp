module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    shell: {
        gae: {
          command: 'mvn appengine:devserver',
          options: {
            async: true,
            execOptions: {
                cwd: 'backend'
            }
          }
        },
        dartDev: {
          command: 'pub serve --port 9002',
          options: {
            async: true,
            execOptions: {
                cwd: 'frontend'
            }
          }
        }
    },
    connect: {
        server: {
            options: {
                port: 9000,
                hostname: 'localhost',
                keepalive: true,
                middleware: function (connect, options) {
                  var proxy = require('grunt-connect-proxy/lib/utils').proxyRequest;
                  return [proxy];
                }
            },
            proxies: [
                {
                    context: '/cahwebapp',
                    host: 'localhost',
                    port: 9003,
                    https: false,
                    xforward: false,
                },
                {
                    context: '/',
                    host: 'localhost',
                    port: 9002,
                    https: false,
                    xforward: false,
                }
            ]
        }
    }
  });

  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-connect-proxy');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-shell-spawn');

  // Default task(s).
  grunt.registerTask('serve', [
    'shell:dartDev',
    'shell:gae',
    'configureProxies:server',
    'connect:server'
  ]);


};
