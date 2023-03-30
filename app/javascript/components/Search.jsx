import React, { useState } from "react";
import axios from "axios";
import WeatherData from "./WeatherData";

const Search = () => {
  const [address, setAddress] = useState('')
  const [loading, setIsLoading] = useState(false)
  const [weatherData, setWeatherData] = useState(null)
  
  const submitAddress = () => {
    setIsLoading(true)
    axios.get(`/api/v1/searches/data?address=${address}`)
      .then(resp => setWeatherData(resp.data.data))
      .finally(setIsLoading(false))    
  }
  
  return(
    <div>
      <input type='text' placeholder='Enter an address or zip code' onChange={e => setAddress(e.target.value)} />
      <button type='submit' onClick={submitAddress}>Submit</button>
      {loading && <div>Loading...</div>}
      {weatherData && (<WeatherData data={weatherData} />)}
    </div>
  )
}

export default Search;