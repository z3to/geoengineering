import axios from 'axios'
import { isUndefined, keys, map, fromPairs, clone } from 'lodash'
import { timeParse } from 'd3-time-format'
import { extent } from 'd3-array'

const parseTime = timeParse('%Y-%m-%V')

const STATUS_IDLE = 'IDLE'
const STATUS_LOADING = 'LOADING'
const STATUS_SUCCESS = 'SUCCESS'
const STATUS_ERROR = 'ERROR'

// Local path where the data is located
const url = 'data/words_by_month.json'

const state = () => {
  return {
    datum: false,
    status: STATUS_IDLE,
    message: ''
  }
}

export const getters = {
  extentX: state => {
    return extent(map(keys(state.datum), key => {
      return parseTime(key)
    }))
  }
}

const mutations = {
  LOAD_DATA (state, { status, datum, message }) {
    if (!isUndefined(status)) {
      state.status = status
    }
    if (!isUndefined(datum)) {
      const months = keys(clone(datum)).sort(function (a, b) {
        return parseTime(b) - parseTime(a)
      })
      state.datum = fromPairs(map(months, month => {
        return [month, clone(datum[month])]
      }))
    }
    if (!isUndefined(message)) {
      state.message = message
    }
  }
}

const actions = {
  loadData ({ state, commit }) {
    if (state.status !== STATUS_SUCCESS) {
      commit('LOAD_DATA', { status: STATUS_LOADING })
      axios.get(url)
        .then(response => {
          // console.log('response:', response.data)
          commit('LOAD_DATA', { status: STATUS_SUCCESS, datum: response.data })
        })
        .catch(error => {
          commit('LOAD_DATA', { status: STATUS_ERROR, message: error })
        })
    }
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
