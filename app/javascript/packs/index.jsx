import React from 'react'
import ReactDOM from 'react-dom'
import MapLayer from "../components/MapLayer";
import configureStore from '../store/configureStore'
import registerServiceWorker from '../registerServiceWorker'
import { Provider } from 'react-redux'

const store = configureStore();

document.addEventListener('turbolinks:load', () => {
  console.log('App rendered..');
  ReactDOM.render(
    <Provider store={store}>
      <React.Fragment>
        <MapLayer isMarkerShown={false}
                  googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyDFO5m8ZOVWZXJZR3rydJWwqwuIb76d5uU&v=3.exp&libraries=geometry,drawing,places"
                  loadingElement={<div style={{ height: `100%` }} />}
                  containerElement={<div style={{ height: `400px` }} />}
                  mapElement={<div style={{ height: `100%` }} />}
        />
      </React.Fragment>
    </Provider>,
    document.body.appendChild(document.createElement('div')),
  )
});

registerServiceWorker();