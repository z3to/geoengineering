<template>
  <footer class="vis-footer">
    <div>
      <span class="clickable btn" @click="updateTerm('cdr, srm')">CDR, SRM</span>
      <span class="clickable btn" @click="updateTerm('sea, earth')">Sea, Earth</span>
      <span class="clickable btn" @click="updateTerm('funding')">Funding</span>
      <span class="clickable btn" @click="updateTerm('russia, usa, europe')">Russia, USA, Europe</span>
      <span class="clickable btn" @click="updateTerm('technologies+technology, models+model')">Technologies + Technolgy, Models + model</span>
    </div>
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
  import { debounce } from 'lodash'

  export default {
    computed: {
      ...mapState([
        'terms'
      ]),
      input: {
        get () {
          return this.$store.state.input
        },
        set: debounce(function (input) {
          this.$store.commit('SET_TERMS', input)
        }, 300)
      }
    },
    methods: {
      updateTerm (input) {
        this.$store.commit('SET_TERMS', input)
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

    .btn {
      padding: $spacing / 6 $spacing / 4;
      border: 1px solid #eee;
      border-radius: 4px;

      &:hover {
        background-color: #eee;
      }
    }
  }

</style>
