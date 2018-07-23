import React, { Component } from 'react'
import {connect} from "react-redux";
import { Icon, Table } from 'semantic-ui-react'

const BuildingList = props =>
    props.buildings.length > 0 ? (
          <Table celled color="black" textAlign="center">
            <Table.Header>
              <Table.Row>
                <Table.HeaderCell>#</Table.HeaderCell>
                <Table.HeaderCell>
                  <Icon name="address" /> Адрес
                </Table.HeaderCell>
                <Table.HeaderCell>
                  <Icon name="distance" /> Расстояние (м)
                </Table.HeaderCell>
              </Table.Row>
            </Table.Header>

            <Table.Body>
            {props.buildings.map((b, index) => (
              <Table.Row key={b.id}>
                <Table.Cell>{index + 1}</Table.Cell>
                <Table.Cell>{b.full_address}</Table.Cell>
                <Table.Cell>{Math.round(b.distance)}</Table.Cell>
              </Table.Row>
            ))}
            </Table.Body>
          </Table>
    ) : <div>Зданий поблизости нет</div>

const mapStateToProps = (state) => {
  return {
    buildings: state.buildings.buildings,
    error: state.buildings.error
  }
}

export default connect(mapStateToProps)(BuildingList)