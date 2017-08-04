#!/bin/bash

## HTML LOADERS ##
HTML_LOADER="
  {
    test: /\.html$/,
    loader: 'html-loader'
  },
"

HAML_LOADER="
  {
    test: /\.(html|haml|hamlc)$/,
    loader: 'haml-loader'
  },
"

PUG_LOADER="
  {
    test: /\.pug$/,
    loader: 'html-loader!pug-html-loader?pretty&exports=false'
  },
"

HANDLEBARS_LOADER="
  {
    test: /\.(hbs|handlebars)$/,
    loader: 'handlebars-loader'
  },
"

## CSS LOADERS ##
CSS_LOADER="
  {
    test: /\.css$/,
    loaders: 'style-loader!css-loader?minimize=true'
  },
"
SASS_LOADER="
  {
    test: /\.scss$/,
    loaders: 'style-loader!css-loader?minimize=true!sass-loader'
  },
"
STYLUS_LOADER="
  {
    test: /\.styl$/,
    loaders: 'style-loader!css-loader?minimize=true!stylus-loader'
  },
"
LESS_LOADER="
  {
    test: /\.less$/,
    loaders: 'style-loader!css-loader?minimize=true!less-loader'
  },
"



function get_webpack_content() {
  echo "
    const path = require('path')
    const webpack = require('webpack')
    const HtmlWebpackPlugin = require('html-webpack-plugin')

    module.exports = {
      context: path.resolve(__dirname, './src'),
      entry: {
        index: './view/index.$1',
        bundle: './js/index.js'
      },
      output: {
        path: path.resolve(__dirname, './build'),
        filename: '[name].bundle.js',
        publicPath: '/'
      },
      devServer: {
        contentBase: path.resolve(__dirname, './src'),
        watchContentBase: true,
        hot: true,
        inline: true,
      },
      plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new HtmlWebpackPlugin({
          title: 'index.html',
          template: 'view/index.$1'
        })
      ],
      module: {
        rules: [
          {
            test: /\.js$/,
            exclude: [/node_modules/],
            use: [{
              loader: 'babel-loader',
              options: { 
                presets: ['es2015'],
                plugins: ['transform-class-properties']
              }
            }],
          },
          $2
          $3
          {
            test: /\.(png|jpg|gif)$/,
            loaders: 'url-loader'
          }
        ],
      },
    }
  "
}

function get_package() {
  echo "{
    \"name\": \"$1\",
    \"version\": \"0.0.1\",
    \"description\": \"\",
    \"main\": \"js/index.js\",
    \"scripts\": {
      \"start\": \"webpack-dev-server\"
    },
    \"author\": \"\",
    \"license\": \"ISC\",
    \"devDependencies\": {}
  }"
}