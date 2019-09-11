<template>
  <g>
    <text
      v-for="area in areaLabels"
      :y="area.y"
      :dominant-baseline="area.down ? 'hanging' : 'baseline'"
      class="area"
      :text-anchor="area.anchor">
      <tspan
        v-for="(row, i) in area.rows"
        :x="area.x"
        :dy="`${area.down ? '' : '-'}${i ? '1' : '0'}em`">
        {{ row }}
      </tspan>
    </text>
  </g>
</template>

<script>
  import { mapState } from 'vuex'
  import { get, words } from 'lodash'

  function getLines (txt) {
    const lineLength = 25
    let parts = words(txt)
    const rows = []
    let row = 0
    while (parts.length) {
      const word = parts.shift()
      let c = get(rows, row, '')
      if (c.length + 1 + word.length < lineLength) {
        // c += ' ' + parts.shift()
        rows[row] = c + (c.length ? ' ' : '') + word
      } else {
        row += 1
        rows[row] = word
      }
    }
    return rows
  }

  export default {
    props: ['margin', 'height', 'width'],
    computed: {
      ...mapState([
        'areas'
      ]),
      areaLabels: function () {
        const { margin, areas, width, height } = this
        const p = 10
        return [{
          x: margin.left + p,
          y: margin.top + p,
          rows: getLines(areas.topLeft),
          anchor: 'start',
          down: true
        }, {
          x: width - margin.right - p,
          y: margin.top + p,
          rows: getLines(areas.topRight),
          anchor: 'end',
          down: true
        }, {
          x: width - margin.left - p,
          y: height - margin.bottom - p,
          rows: getLines(areas.bottomRight),
          anchor: 'end',
          down: false
        }, {
          x: margin.right + p,
          y: height - margin.bottom - p,
          rows: getLines(areas.bottomLeft),
          anchor: 'start',
          down: false
        }]
      }
    }
  }
</script>
