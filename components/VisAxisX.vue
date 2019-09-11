<template>
  <g class="axisX">
    <line
      class="axis"
      :x1="margin.left"
      :x2="width - margin.right"
      :y1="height - margin.bottom"
      :y2="height - margin.bottom" />
    <text
      class="axis"
      :x="axis.x + 'px'"
      :y="height - d * 1.5 + 'px'"
      text-anchor="middle"
      dominant-baseline="baseline">
      {{ axis.label }}
    </text>
    <g
      v-for="tick in axis.ticks"
      :key="tick.key">
      <text
        :x="tick.x + 'px'"
        :y="height - d * 4.5 + 'px'"
        text-anchor="middle"
        dominant-baseline="middle"
        class="tick">
        {{ tick.label }}
      </text>
      <line
        :y1="height - margin.bottom + 'px'"
        :x1="tick.x + 'px'"
        :y2="height - d * 5 + 'px'"
        :x2="tick.x + 'px'"
        class="tick" />
    </g>
  </g>
</template>

<script>
  import map from 'lodash/map'
  import mean from 'lodash/mean'
  import { timeFormat } from 'd3-time-format'

  const f = timeFormat('%Y-%m')

  export default {
    props: ['margin', 'height', 'width', 'scaleX', 'label', 'meanValue'],
    computed: {
      d: function () {
        return this.margin.bottom / 6
      },
      axis: function () {
        const { scaleX, d, height } = this
        const x = mean(scaleX.range())
        return {
          label: this.label,
          y: 20,
          x,
          ticks: map(scaleX.ticks(5), (tick, i) => {
            return {
              key: i,
              label: f(tick),
              x: scaleX(tick),
              f: height - d
            }
          })
        }
      }
    }
  }
</script>
