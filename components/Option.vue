<template>
  <li @click="action(id)" :class="{ active: id === current }">{{ label }}</li>
</template>

<script>
  export default {
    props: {
      current: {
        type: String
      },
      id: {
        type: String
      },
      label: {
        type: String
      },
      action: {
        type: Function
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/style/global";

  li {
    &.active {
      font-weight: bold;
    }
  }

</style>
