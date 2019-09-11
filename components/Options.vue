<template>
  <footer class="vis-footer">
    <div>
      <strong>Try:</strong>
      <ul>
        <li class="clickable btn" @click="updateTerm('cdr, srm')">CDR, SRM</li>
        <li class="clickable btn" @click="updateTerm('sea, earth')">Sea, Earth</li>
        <li class="clickable btn" @click="updateTerm('funding')">Funding</li>
        <li class="clickable btn" @click="updateTerm('russia, usa, europe')">Russia, USA, Europe</li>
        <li class="clickable btn" @click="updateTerm('technologies+technology, models+model')">Technologies + Technolgy, Models + model</li>
        <li class="clickable btn" @click="updateTerm('technology+technolgies, nature+earth+planet+sea')">technology + technolgies, nature + earth + planet + sea</li>
      </ul>
    </div>
    <div>
      <strong>Search terms</strong>
      <input type="text" v-model="input" />
    </div>
    <ul>
      <li
        v-for="term in terms"
        v-html="term.term"
        class="terms"
        :style="{ backgroundColor: term.color }" />
    </ul>
    <div>
      <strong>Most used words</strong>
      <ul>
        <li class="clickable btn" @click="updateTerm('climate')" v-html="'climate'" />
        <li class="clickable btn" @click="updateTerm('research')" v-html="'research'" />
        <li class="clickable btn" @click="updateTerm('carbon')" v-html="'carbon'" />
        <li class="clickable btn" @click="updateTerm('change')" v-html="'change'" />
        <li class="clickable btn" @click="updateTerm('emissions')" v-html="'emissions'" />
        <li class="clickable btn" @click="updateTerm('governance')" v-html="'governance'" />
        <li class="clickable btn" @click="updateTerm('srm')" v-html="'srm'" />
        <li class="clickable btn" @click="updateTerm('engineering')" v-html="'engineering'" />
        <li class="clickable btn" @click="updateTerm('warming')" v-html="'warming'" />
        <li class="clickable btn" @click="updateTerm('world')" v-html="'world'" />
        <li class="clickable btn" @click="updateTerm('technologies')" v-html="'technologies'" />
        <li class="clickable btn" @click="updateTerm('energy')" v-html="'energy'" />
        <li class="clickable btn" @click="updateTerm('risks')" v-html="'risks'" />
        <li class="clickable btn" @click="updateTerm('ocean')" v-html="'ocean'" />
        <li class="clickable btn" @click="updateTerm('technology')" v-html="'technology'" />
        <li class="clickable btn" @click="updateTerm('policy')" v-html="'policy'" />
        <li class="clickable btn" @click="updateTerm('university')" v-html="'university'" />
        <li class="clickable btn" @click="updateTerm('dioxide')" v-html="'dioxide'" />
        <li class="clickable btn" @click="updateTerm('time')" v-html="'time'" />
        <li class="clickable btn" @click="updateTerm('https')" v-html="'https'" />
        <li class="clickable btn" @click="updateTerm('atmosphere')" v-html="'atmosphere'" />
        <li class="clickable btn" @click="updateTerm('science')" v-html="'science'" />
        <li class="clickable btn" @click="updateTerm('temperature')" v-html="'temperature'" />
        <li class="clickable btn" @click="updateTerm('effects')" v-html="'effects'" />
        <li class="clickable btn" @click="updateTerm('radiation')" v-html="'radiation'" />
        <li class="clickable btn" @click="updateTerm('water')" v-html="'water'" />
        <li class="clickable btn" @click="updateTerm('%')" v-html="'%'" />
        <li class="clickable btn" @click="updateTerm('impacts')" v-html="'impacts'" />
        <li class="clickable btn" @click="updateTerm('people')" v-html="'people'" />
        <li class="clickable btn" @click="updateTerm('ice')" v-html="'ice'" />
        <li class="clickable btn" @click="updateTerm('cdr')" v-html="'cdr'" />
        <li class="clickable btn" @click="updateTerm('removal')" v-html="'removal'" />
        <li class="clickable btn" @click="updateTerm('years')" v-html="'years'" />
        <li class="clickable btn" @click="updateTerm('scientists')" v-html="'scientists'" />
        <li class="clickable btn" @click="updateTerm('report')" v-html="'report'" />
        <li class="clickable btn" @click="updateTerm('paper')" v-html="'paper'" />
        <li class="clickable btn" @click="updateTerm('system')" v-html="'system'" />
        <li class="clickable btn" @click="updateTerm('aerosol')" v-html="'aerosol'" />
        <li class="clickable btn" @click="updateTerm('air')" v-html="'air'" />
        <li class="clickable btn" @click="updateTerm('management')" v-html="'management'" />
        <li class="clickable btn" @click="updateTerm('earth')" v-html="'earth'" />
        <li class="clickable btn" @click="updateTerm('deployment')" v-html="'deployment'" />
        <li class="clickable btn" @click="updateTerm('way')" v-html="'way'" />
        <li class="clickable btn" @click="updateTerm('sea')" v-html="'sea'" />
        <li class="clickable btn" @click="updateTerm('year')" v-html="'year'" />
        <li class="clickable btn" @click="updateTerm('project')" v-html="'project'" />
        <li class="clickable btn" @click="updateTerm('gas')" v-html="'gas'" />
        <li class="clickable btn" @click="updateTerm('mitigation')" v-html="'mitigation'" />
        <li class="clickable btn" @click="updateTerm('use')" v-html="'use'" />
        <li class="clickable btn" @click="updateTerm('model')" v-html="'model'" />
        <li class="clickable btn" @click="updateTerm('greenhouse')" v-html="'greenhouse'" />
        <li class="clickable btn" @click="updateTerm('countries')" v-html="'countries'" />
        <li class="clickable btn" @click="updateTerm('work')" v-html="'work'" />
        <li class="clickable btn" @click="updateTerm('effect')" v-html="'effect'" />
        <li class="clickable btn" @click="updateTerm('development')" v-html="'development'" />
        <li class="clickable btn" @click="updateTerm('scale')" v-html="'scale'" />
        <li class="clickable btn" @click="updateTerm('it’s')" v-html="'it’s'" />
        <li class="clickable btn" @click="updateTerm('one')" v-html="'one'" />
        <li class="clickable btn" @click="updateTerm('assessment')" v-html="'assessment'" />
        <li class="clickable btn" @click="updateTerm('cost')" v-html="'cost'" />
        <li class="clickable btn" @click="updateTerm('surface')" v-html="'surface'" />
        <li class="clickable btn" @click="updateTerm('capture')" v-html="'capture'" />
        <li class="clickable btn" @click="updateTerm('andrew')" v-html="'andrew'" />
        <li class="clickable btn" @click="updateTerm('level')" v-html="'level'" />
        <li class="clickable btn" @click="updateTerm('risk')" v-html="'risk'" />
        <li class="clickable btn" @click="updateTerm('environment')" v-html="'environment'" />
        <li class="clickable btn" @click="updateTerm('models')" v-html="'models'" />
        <li class="clickable btn" @click="updateTerm('future')" v-html="'future'" />
        <li class="clickable btn" @click="updateTerm('cloud')" v-html="'cloud'" />
        <li class="clickable btn" @click="updateTerm('aerosols')" v-html="'aerosols'" />
        <li class="clickable btn" @click="updateTerm('process')" v-html="'process'" />
        <li class="clickable btn" @click="updateTerm('part')" v-html="'part'" />
        <li class="clickable btn" @click="updateTerm('paris')" v-html="'paris'" />
        <li class="clickable btn" @click="updateTerm('changes')" v-html="'changes'" />
        <li class="clickable btn" @click="updateTerm('study')" v-html="'study'" />
        <li class="clickable btn" @click="updateTerm('group')" v-html="'group'" />
        <li class="clickable btn" @click="updateTerm('idea')" v-html="'idea'" />
        <li class="clickable btn" @click="updateTerm('temperatures')" v-html="'temperatures'" />
        <li class="clickable btn" @click="updateTerm('information')" v-html="'information'" />
        <li class="clickable btn" @click="updateTerm('example')" v-html="'example'" />
        <li class="clickable btn" @click="updateTerm('agreement')" v-html="'agreement'" />
        <li class="clickable btn" @click="updateTerm('injection')" v-html="'injection'" />
        <li class="clickable btn" @click="updateTerm('geoengineering')" v-html="'geoengineering'" />
        <li class="clickable btn" @click="updateTerm('al')" v-html="'al'" />
        <li class="clickable btn" @click="updateTerm('ipcc')" v-html="'ipcc'" />
        <li class="clickable btn" @click="updateTerm('i')" v-html="'i'" />
        <li class="clickable btn" @click="updateTerm('problem')" v-html="'problem'" />
        <li class="clickable btn" @click="updateTerm('stratosphere')" v-html="'stratosphere'" />
        <li class="clickable btn" @click="updateTerm('issues')" v-html="'issues'" />
        <li class="clickable btn" @click="updateTerm('space')" v-html="'space'" />
        <li class="clickable btn" @click="updateTerm('fossil')" v-html="'fossil'" />
        <li class="clickable btn" @click="updateTerm('response')" v-html="'response'" />
        <li class="clickable btn" @click="updateTerm('costs')" v-html="'costs'" />
        <li class="clickable btn" @click="updateTerm('harvard')" v-html="'harvard'" />
        <li class="clickable btn" @click="updateTerm('need')" v-html="'need'" />
        <li class="clickable btn" @click="updateTerm('point')" v-html="'point'" />
        <li class="clickable btn" @click="updateTerm('efforts')" v-html="'efforts'" />
        <li class="clickable btn" @click="updateTerm('approach')" v-html="'approach'" />
        <li class="clickable btn" @click="updateTerm('land')" v-html="'land'" />
        <li class="clickable btn" @click="updateTerm('planet')" v-html="'planet'" />
        <li class="clickable btn" @click="updateTerm('arctic')" v-html="'arctic'" />
      </ul>
    </div>
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
    grid-row-gap: $spacing / 2;
    width: 60vw;
    height: 30vh;
    margin-top: 2vh;

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
      display: inline-block;
      padding: $spacing / 8 $spacing / 4;
      margin: $spacing / 6 0;
      border-radius: 4px;
      font-size: 0.8rem;

      &.terms {
        color: #fff;
        margin: $spacing / 6 $spacing / 8;
      }

      &:first-child {
        margin-left: 0;
      }

      &:last-child {
        margin-right: 0;
      }
    }

    .btn {
      border: 1px solid #eee;
      border-radius: 4px;

      &:hover {
        background-color: #eee;
      }
    }
  }

</style>
