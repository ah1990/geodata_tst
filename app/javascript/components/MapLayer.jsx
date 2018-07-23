import React from 'react'
import { withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps"
import { connect } from 'react-redux'
import { findBuildings } from '../actions/types/buildingsActions'
import BuildingList from "../components/BuildingList"

const MapLayer = withScriptjs(withGoogleMap((props) => {

  const getCoordinates = e => {
    console.log('Clicked on map');

    let lat = e.latLng.lat(), lon = e.latLng.lng();
    console.log(`Lat ${lat}`);
    console.log(`Lon ${lon}`);
    props.find(lon, lat)
  };

  return (
    <React.Fragment>
      <GoogleMap
        defaultZoom={13}
        defaultCenter={{lat: 55.750144, lng: 37.617902}}
        onClick={(e) => getCoordinates(e)}
      >
        {props.isMarkerShown && <Marker position={{lat: 55.750144, lng: 37.617902}}/>}
      </GoogleMap>
      <BuildingList/>
    </React.Fragment>
  )
}
));

const mapStateToProps = state => {
  return {
    buildings: state.buildings.buildings,
    error: state.buildings.error
  }
};

const mapDispatchToProps = dispatch => ({
  find: (lon, lat) => dispatch(findBuildings(lon, lat))
});

export default connect(mapStateToProps, mapDispatchToProps)(MapLayer);