// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

// Import Vue & Lux
import Vue from "vue";
import system from "lux-design-system";
import "lux-design-system/dist/system/system.css";

Vue.use(system);

document.addEventListener("DOMContentLoaded", () => {
  // Select all elements with the class name "lux"
  [...document.getElementsByClassName("lux")].forEach(el => {
    new Vue({ el });
  });
});
