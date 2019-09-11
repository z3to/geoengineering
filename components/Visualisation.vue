<template>
  <div class="vis-container" ref="vis">
    <svg width="100%" height="100%" class="vis">
      <transition name="fade">
        <LineChart
          v-if="isVisible"
          :scaleX="scaleX"
          :scaleY="scaleY"
          :width="width"
          :height="height"
          :margin="margin" />
      </transition>
    </svg>
  </div>
</template>

<script>
  import { mapState, mapGetters } from 'vuex'
  import { scaleLinear, scaleTime } from 'd3-scale'
  import { extent } from 'd3-array'
  import { map, flatten } from 'lodash'
  import LineChart from '~/components/LineChart.vue'

  export default {
    data: function () {
      return {
        width: 0,
        height: 0,
        margin: {
          left: 50,
          right: 50,
          top: 50,
          bottom: 50
        }
      }
    },
    computed: {
      ...mapState({
        'status': state => state.data.status
      }),
      ...mapGetters([
        'data',
        'extentX'
      ]),
      isVisible: function () {
        const { width, height, status } = this
        return width && height && status === 'SUCCESS'
      },
      scaleX: function () {
        return scaleTime()
          .range([this.margin.left, this.width - this.margin.right])
          .domain(this.extentX).nice()
      },
      extentY: function () {
        const range = flatten(map(this.data, term => {
          return map(term.data, 1)
        }))
        return extent(range)
      },
      scaleY: function () {
        return scaleLinear()
          .range([this.height - this.margin.bottom, this.margin.top])
          .domain(this.extentY).nice()
      }
    },
    methods: {
      calcSizes: function () {
        const { vis: el } = this.$refs
        const width = el.clientWidth || el.parentNode.clientWidth
        const height = el.clientHeight || el.parentNode.clientHeight
        this.width = width
        this.height = height
      }
    },
    mounted () {
      this.calcSizes()
      window.addEventListener('resize', this.calcSizes, false)
    },
    beforeDestroy () {
      window.removeEventListener('resize', this.calcSizes, false)
    },
    components: {
      LineChart
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/style/global";

  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }
  .fade-enter, .fade-leave-to {
    opacity: 0;
  }

  .vis-container {
    width: 90vw;
    height: 60vh;
    max-height: 900px;
  }

  .vis-notes {
    margin: $spacing * 2 0;

    h2 {
      margin-top: $spacing;
    }
  }
</style>
