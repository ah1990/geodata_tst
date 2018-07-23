import axios from 'axios'

const BASE_URL = `${window.location.origin}/api/v1`;

export default class Api {
  static getNearestBuildings(lon, lat) {
    return axios.get(`${BASE_URL}/buildings?lon=${lon}&lat=${lat}`)
  }
}