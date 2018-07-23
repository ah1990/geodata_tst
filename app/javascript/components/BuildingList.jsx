import React, { Component } from 'react'
import {connect} from "react-redux";

class BuildingList extends Component {
  render() {
    return (
      <div>
        {this.props.buildings && this.props.buildings.map(b => (
          <div key={b.id}>{b.full_address} - {b.distance}</div>
        ))}
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    buildings: state.buildings.buildings,
    error: state.buildings.error
  }
}

export default connect(mapStateToProps)(BuildingList)