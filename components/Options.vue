<template>
  <footer class="vis-footer">
    <input type="text" v-model="input" />
    <ul>
      <li
        v-for="term in terms"
        v-html="term.term"
        :style="{ backgroundColor: term.color }" />
    </ul>
  </footer>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState([
        'terms'
      ]),
      input: {
        get () {
          return this.$store.state.input
        },
        set (input) {
          this.$store.commit('SET_TERMS', input)
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "~@/assets/style/global";

  .vis-footer {
    display: grid;
    grid-column-gap: $spacing;
    grid-row-gap: $spacing;
    width: 50vw;

    ul, input {
      letter-spacing: 0.05em;
      font-size: 1rem;
      width: 100%;
      display: block;
    }

    input {
      padding: $spacing / 2;
    }

    ul li {
      display: inline;
      padding: $spacing / 6 $spacing / 4;
      margin: 0 $spacing / 4;
      border-radius: 4px;
      color: #fff;

      &:first-child {
        margin-left: 0;
      }

      &:last-child {
        margin-right: 0;
      }
    }
  }

</style>
