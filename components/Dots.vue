<template>
  <g>
    <circle
      v-for="dot in points"
      :cx="dot[0]"
      :cy="dot[1]"
      :r="dot[3]"
      :style="{ fill: dot[4] }"
      :class="{ dot: true, active: isActive }"
      v-tooltip="{ content: tooltip, show: isActive, offset: 2 }" />
  </g>
</template>

<script>
  import { template, isObject } from 'lodash'

  export default {
    props: {
      points: {
        type: Array,
        default: []
      },
      active: {
        type: [Boolean, Object],
        default: false
      }
    },
    computed: {
      isActive: function () {
        return isObject(this.active)
      },
      tooltip: function () {
        const str = template('<h4><%= country %></h4><dl><dt>Region</dt><dd><%= region %></dd><dt>TCI</dt><dd><%= tci %></dd><dt>GAIN</dt><dd><%= gain %></dd><dt>Total</dt><dd><%= rescaled %></dd><dt>Emissions</dt><dd><%= emissions %></dd></dl>')
        return this.isActive ? str(this.active) : ''
      }
    }
  }
</script>

<style lang="scss">
  @import "~@/assets/style/global";

  .tooltip-inner {
    dl {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-gap: 5px;
    }
  }
</style>