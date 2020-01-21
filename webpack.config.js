const path = require('path');
const webpack = require('webpack');
const ManifestPlugin = require('webpack-manifest-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  entry: {
    bundle: path.resolve(__dirname, 'frontend/index.js')
  },
  output: {
    path: path.resolve(__dirname, 'public/dist/'),
    filename: '[name]-[hash].js',
    chunkFilename: '[name].bundle-[hash].js',
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
          },
          'css-loader',
        ]
      },
      { test: /\.(ttf|eot|svg|woff(2)?)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader", options: { publicPath: '/dist/' } }
    ]
  },
  plugins: [
    new ManifestPlugin({
      fileName: 'manifest.json',
      publicPath: '/dist/',
      writeToFileEmit: true,
    }),
    new MiniCssExtractPlugin({
      filename: "[name]-[hash].css",
      chunkFilename: "[id].css"
    })
  ],
};
