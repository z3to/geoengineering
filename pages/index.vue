<template>
  <div class="wrapper">
    <Visualisation />
    <Options />
  </div>
</template>

<script>
  import { mapActions } from 'vuex'
  import Visualisation from '~/components/Visualisation.vue'
  import Options from '~/components/Options.vue'

  export default {
    methods: {
      ...mapActions([
        'loadData'
      ])
    },
    components: {
      Visualisation,
      Options
    },
    created () {
      console.log('Load data in index')
      this.loadData()
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/style/global";

  .wrapper {
  	display: flex;
    align-items: center;
    width: 100%;
    min-height: 100%;
    flex-direction: column;
  }
</style>
