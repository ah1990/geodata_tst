import * as types from '../../actions/types/buildingTypes'

const initialState = {
  buildings: [],
  error: ''
};

export default function buildings(state = initialState, { type, payload }) {
  switch (type) {
    case types.FIND_BUILDINGS:
      return { ...state, buildings: payload.buildings };
    case types.FIND_BUILDINGS_ERROR:
      return { ...state, error: payload };
    default:
      return state
  }
}