import * as types from './buildingTypes'
import Api from '../../api'

export const findBuildingsAction = buildings => ({
  type: types.FIND_BUILDINGS,
  payload: { buildings }
});

export const findBuildings = (lon, lat) => dispatch => {
  return Api.getNearestBuildings(lon, lat).then(response => {
    debugger;
    dispatch(findBuildingsAction(response.data.buildings));
  })
};