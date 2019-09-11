<template>
  <g>
    <VisAxis
      :scaleX="scaleX"
      :scaleY="scaleY"
      :width="width"
      :height="height"
      :margin="margin" />
    <path
      v-for="line in lines"
      :style="{ stroke: line.color, fill: line.color }"
      :d="line.d" />
  </g>
</template>

<script>
  import { mapState, mapGetters } from 'vuex'
  import VisAxis from '~/components/VisAxis.vue'
  import { map } from 'lodash'
  import { line, curveCardinal } from 'd3-shape'

  export default {
    props: ['scaleX', 'scaleY', 'width', 'height', 'margin'],
    computed: {
      ...mapState([
        'axis'
      ]),
      ...mapGetters([
        'data'
      ]),
      lines: function () {
        const { scaleX, scaleY } = this

        var pathFunction = line()
          .curve(curveCardinal)
          .x(d => { return scaleX(d[0]) })
          .y(d => { return scaleY(d[1]) })

        return map(this.data, datum => {
          return {
            color: datum.color,
            d: pathFunction(datum.data)
          }
        })
      }
    },
    components: {
      VisAxis
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/style/global";

  path {
    fill: none;
    stroke-width: 2px;
    fill-opacity: 0.05;
  }

</style>