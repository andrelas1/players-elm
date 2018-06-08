var path = require('path');
var MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: {
    app: ['./src/index.js'],
  },
  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },
  devtool: 'source-map',
  mode: 'development',
  module: {
    rules: [
      {
        test: /\.scss$/,
        exclude: ['node_modules'],
        use: [
          {
            loader: process.env.NODE_ENV !== 'production' ? 'style-loader' : MiniCssExtractPlugin.loader
          },
          {
            loader: 'css-loader',
          },
          {
            loader: 'sass-loader'
          }
        ],
      },
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]',
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader?verbose=true&warn=true',
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff',
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
      },
    ],
    noParse: /\.elm$/,
  },
  devServer: {
    inline: true,
    stats: { colors: true },
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: '[name].css',
      chunkFilename: '[id].css'
    })
  ]
};
