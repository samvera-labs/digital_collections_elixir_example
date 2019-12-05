<template>
  <form>
    <input-text
      id="bar"
      name="value"
      label="Input"
      placeholder="Write your text"
      helper="This is helper text to help the user fill out this field"
    ></input-text>
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
