echo "Creating react app from scratch for you !!"
echo "Enter the name for your react-app : "
read name
pwd
mkdir $name
cd $name
npm init -y
npm i react react-dom
npm i -D webpack webpack-dev-server webpack-cli html-webpack-plugin css-loader style-loader babel-loader @babel/preset-env @babel/preset-react
touch webpack.config.js
echo "const HtmlWebPackPlugin = require(\"html-webpack-plugin\");
const path = require(\"path\");
var webpack = require(\"webpack\");

module.exports = {
  entry: \"./src/index.js\",
  output: {
    path: path.resolve(__dirname, \"dist\"),
    filename: \"bundle.js\",
    library: \"entrypoint\",
  },
  devServer: {
    historyApiFallback: true,
    hot: true,
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: \"babel-loader\",
      },
      {
        test: /\.css$/,
        use: [\"style-loader\", \"css-loader\"],
      },
    ],
  },
  plugins: [
    new HtmlWebPackPlugin({
      template: path.resolve(__dirname, \"src/index.html\"),
      filename: \"index.html\",
      hash: true,
    }),
    new webpack.ProvidePlugin({
      React: \"react\",
    }),
  ],
};
">webpack.config.js


touch .babelrc
echo "{
    \"presets\": [\"@babel/preset-env\",\"@babel/preset-react\"]
}">.babelrc


if [ -z $(which jq) ]
then brew install jq
fi

echo $(jq 'del(.scripts)' package.json ) > package.json
echo $((jq '. += {"scripts":{"start" :"webpack-dev-server --mode=development"}}' package.json ) )  > package.json



mkdir src
cd src
mkdir components
touch main.css
touch index.html
touch index.js


echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>"$name"</title>
</head>
<body>
  <div id="root"></div>    
</body>
</html>">index.html

echo "import reactDom from \"react-dom/client\";
import App from \"./components/App\";
import \"./main.css\";
const root=reactDom.createRoot(document.getElementById(\"root\"));
root.render(<App/>)
if(module.hot)
module.hot.accept();
">>index.js

echo "body {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: black;
}
#root {
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1px solid rgb(211, 216, 206);
  padding: 2vh;
  font-family: fantasy;
  font-size: xx-large;
  font-weight: 700;
  color: cornflowerblue;
  position: absolute;
  top: 50vh;
  left: 50vw;
  translate: -50% -50%;
}
"> main.css


cd components
touch App.js
echo "export default ()=>{
    return <div>Welcome to scra by Shreyanshi</div>;

}">App.js

