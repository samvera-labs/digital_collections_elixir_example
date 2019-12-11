// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../styles/app.scss";

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

// Import non-Lux Vue components
import "./components/_components";

// Import Vue & Lux
import Vue from "vue";
import system from "lux-design-system";
import "lux-design-system/dist/system/system.css";

// Phoenix Live View
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live", Socket)
liveSocket.connect()

Vue.use(system);

document.addEventListener("DOMContentLoaded", () => {
  // Select all elements with the class name "lux"
  [...document.getElementsByClassName("lux")].forEach(el => {
    new Vue({ el });
  });
});
