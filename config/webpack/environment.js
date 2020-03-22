const { environment } = require('@rails/webpacker')

// [Rails 6 でjQueryを使う - Qiita](https://qiita.com/hizukayudai/items/4eea87cb9356860eec62)
// ここ見て書いた
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

module.exports = environment
