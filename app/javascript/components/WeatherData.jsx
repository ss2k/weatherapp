import React from "react";

const WeatherData = ({ data }) => {
  return(
    <div>
      <div>Current: {data.temp}</div>
      <div>Conditions: {data.weather}</div>
      <div>High: {data.max}</div>
      <div>Low: {data.min}</div>
    </div>
  )
}

export default WeatherData;