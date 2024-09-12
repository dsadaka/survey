# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "mrujs", to: "https://ga.jspm.io/npm:mrujs@0.7.1/dist/mrujs.module.js"
pin "morphdom", to: "https://ga.jspm.io/npm:morphdom@2.6.1/dist/morphdom.js"