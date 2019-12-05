import Vue from "vue";
import luxElements from "./_lux-elements-used";
Vue.config.ignoredElements = [...luxElements];

// Step 1: import Vue component here
import Message from "./Message";
import VanillaVueInput from "./VanillaVueInput";
import LuxInput from "./LuxInput";

// Step 2: add to the array to batch instantiate
const vueComponents = [
  { elementId: "#message", vueComponent: Message },
  { elementId: "#vanilla-vue-input", vueComponent: VanillaVueInput },
  { elementId: "#lux-input", vueComponent: LuxInput }
];

vueComponents.forEach(item => {
  new Vue({
    render: h => h(item.vueComponent)
  }).$mount(item.elementId);
});
