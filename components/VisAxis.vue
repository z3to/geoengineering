<template>
  <g>
    <VisAxisX
      :margin="margin"
      :height="height"
      :width="width"
      :scaleX="scaleX"
      :label="'Time'" />
    <VisAxisY
      :margin="margin"
      :height="height"
      :width="width"
      :scaleY="scaleY"
      :label="'Amount'" />
  </g>
</template>

<script>
  import VisAxisY from '~/components/VisAxisY.vue'
  import VisAxisX from '~/components/VisAxisX.vue'

  export default {
    props: ['scaleX', 'scaleY', 'margin', 'height', 'width'],
    components: {
      VisAxisY,
      VisAxisX
    }
  }
</script>
