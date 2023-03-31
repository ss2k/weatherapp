import React from "react";

const WeatherData = ({ data }) => {
  return(
      <div className="weather_box">
        <h1>{data.weather}{data.cache && <> - &Delta;</>}</h1>
        <span className="temp">{data.temp}&deg;F</span>
        <span className="high-low">{data.min}&deg;F / {data.max}F&deg;</span>
      </div>
  )
}

export default WeatherData;
