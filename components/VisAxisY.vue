<template>
	<g class="axisY">
    <line
      class="axis"
      :x1="margin.left"
      :x2="margin.left"
      :y1="margin.top"
      :y2="height - margin.bottom" />
    <text
      class="axis"
      :x="d * 1.5 + 'px'"
      :y="axis.y + 'px'"
      :transform="`rotate(-90 ${d * 1.5} ${axis.y})`"
      text-anchor="middle"
      dominant-baseline="baseline">
      {{ axis.label }}
    </text>
    <g
      v-for="tick in axis.ticks"
      :key="tick.key">
      <text
        :y="tick.y + 'px'"
        :x="d * 4.5 + 'px'"
        text-anchor="end"
        dominant-baseline="middle"
        class="tick">
        {{ tick.label }}
      </text>
      <line
        :x1="margin.left + 'px'"
        :y1="tick.y + 'px'"
        :x2="d * 5 + 'px'"
        :y2="tick.y + 'px'"
        class="tick" />
    </g>
  </g>
</template>

<script>
  import map from 'lodash/map'
  import mean from 'lodash/mean'

  export default {
    props: ['margin', 'height', 'width', 'scaleY', 'label', 'meanValue'],
    computed: {
      d: function () {
        return this.margin.left / 6
      },
      axis: function () {
        const { scaleY, d } = this
        const y = scaleY(mean(scaleY.domain()))
        return {
          label: this.label,
          x: 20,
          y,
          ticks: map(scaleY.ticks(5), (tick, i) => {
            return {
              key: i,
              label: tick,
              y: scaleY(tick),
              x: d
            }
          })
        }
      }
    }
  }
</script>
