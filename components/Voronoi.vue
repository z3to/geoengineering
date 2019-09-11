<template>
  <g>
    <Dots
      v-if="activeItem"
      :points="[activeItem]"
      :active="activeCountry" />
    <path
      v-for="(poly, id) in polygons"
      :d="poly.path"
      @mouseenter="hoverItem(poly.dot)"
      @mouseleave="hoverItem()" />
  </g>
</template>

<script>
  import { mapState, mapGetters, mapActions } from 'vuex'
  import { map } from 'lodash'
  import { Delaunay } from 'd3-delaunay'
  import Dots from '~/components/Dots.vue'

  export default {
    props: ['scaleX', 'scaleY', 'scaleR', 'points'],
    computed: {
      ...mapState({
        'activeItem': state => state.hover.activeItem
      }),
      ...mapGetters([
        'activeCountry',
        'data'
      ]),
      polygons: function () {
        const { scaleX, scaleY, points: dots } = this

        const [x0, x1] = scaleX.range()
        const [y1, y0] = scaleY.range()

        const voronoi = Delaunay.from(dots).voronoi([x0, y0, x1, y1])

        return map(dots, (dot, i) => {
          const points = voronoi.cellPolygon(i)
          const path = map(points, point => {
            return point.join(' ')
          })
          return {
            path: `M${path.join('L')}Z`,
            dot
          }
        })
      }
    },
    methods: {
      ...mapActions([
        'hoverItem'
      ])
    },
    components: {
      Dots
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/style/global";

  path {
    fill: none;
    stroke: none;
    pointer-events: all;
  }
</style>
