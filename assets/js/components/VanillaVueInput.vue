<template>
  <form>
    <fieldset>
      <input v-model="message" type="text" placeholder="Type a value here..." />
    </fieldset>
    <p>Value: {{ message }}</p>
  </form>
</template>

<script>
export default {
  data() {
    return {
      message: ""
    };
  }
};
</script>
