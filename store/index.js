import Vue from 'vue'
import Vuex from 'vuex'
import VTooltip from 'v-tooltip'
import data from './modules/data'
import { isUndefined, words, map, slice, get, forEach, fromPairs, sum, lowerCase } from 'lodash'
import { schemeCategory10 } from 'd3-scale-chromatic'
import { timeParse } from 'd3-time-format'

const parseTime = timeParse('%Y-%m-%V')

Vue.use(VTooltip)
Vue.use(Vuex)

export const state = () => {
  return {
    terms: [],
    input: undefined
  }
}

export const getters = {
  data: state => {
    const data = get(state, ['data', 'datum'], [])
    const terms = get(state, ['terms'], [])
    const months = fromPairs(map(terms, term => {
      return [
        term.term,
        {
          ...term,
          data: []
        }
      ]
    }))

    forEach(data, (list, month) => {
      const date = parseTime(month)
      forEach(terms, term => {
        const chain = term.term.split('+')
        const amount = sum(map(chain, item => {
          return get(list, item, 0)
        }))
        months[term.term].data.push([date, amount])
      })
    })
    return months
  }
}

export const modules = {
  data
}

export const mutations = {
  SET_TERMS (state, input) {
    state.input = input
    if (!isUndefined(input)) {
      const terms = map(slice(words(input, /[^, ]+/g), 0, 11), lowerCase)
      state.terms = map(terms, (term, i) => {
        return {
          term,
          color: schemeCategory10[i]
        }
      })
    }
  }
}

export const actions = {
  setTerms ({ state, commit }, terms) {
    commit('SET_TERMS', terms)
  }
}
