<template>
  <div class="vue-message">
    <button v-on:click="sayHello">Click me</button>
    <div v-if="showMessage">{{ message }}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "I'm a non-Lux Vue component",
      showMessage: false
    };
  },
  methods: {
    sayHello: function(e) {
      this.showMessage = !this.showMessage;
    }
  },
  created() {
    console.log("Vue component created");
  }
};
</script>

<style>
.vue-message {
  text-align: left;
}
</style>
