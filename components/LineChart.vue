<template>
  <g>
    <VisAxis
      :scaleX="scaleX"
      :scaleY="scaleY"
      :width="width"
      :height="height"
      :margin="margin" />
    <g
      v-for="line in lines">
      <path
        class="path"
        :style="{ stroke: line.color }"
        :d="line.d" />
      <path
        class="area"
        :style="{ fill: line.color }"
        :d="line.area" />
    </g>
  </g>
</template>

<script>
  import { mapState, mapGetters } from 'vuex'
  import VisAxis from '~/components/VisAxis.vue'
  import { map } from 'lodash'
  import { line, curveCardinal, area } from 'd3-shape'

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

        const pathFunction = line()
          .curve(curveCardinal)
          .x(d => { return scaleX(d[0]) })
          .y(d => { return scaleY(d[1]) })

        const areaFunction = area()
          .curve(curveCardinal)
          .x(d => { return scaleX(d[0]) })
          .y1(d => { return scaleY(d[1]) })
          .y0(scaleY(0))

        return map(this.data, datum => {
          return {
            color: datum.color,
            d: pathFunction(datum.data),
            area: areaFunction(datum.data)
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
    &.path {
      fill: none;
      stroke-width: 2px;
    }

    &.area {
      fill-opacity: 0.05;
    }
  }

</style>