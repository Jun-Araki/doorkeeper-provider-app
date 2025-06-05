# config/importmap.rb
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# Action Cable関連のピンを追加
pin "@rails/actioncable", to: "actioncable.esm.js" # これは通常Railsによって自動でpinされる
pin "channels", to: "channels/index.js" # app/javascript/channels/index.jsを 'channels' としてピン
pin "channels/consumer", to: "channels/consumer.js" # consumer.jsを直接ピンすることも可能
pin "channels/message_channel", to: "channels/message_channel.js" # message_channel.jsを直接ピン
