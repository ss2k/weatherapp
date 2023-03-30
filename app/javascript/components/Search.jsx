import React, { useState } from "react";
import axios from "axios";
import WeatherData from "./WeatherData";

const Search = () => {
  const [address, setAddress] = useState('')
  const [loading, setIsLoading] = useState(false)
  const [weatherData, setWeatherData] = useState(null)
  const [error, setError] = useState(null)
  
  const submitAddress = () => {
    setIsLoading(true)
    clearState()
    
    axios.get(`/api/v1/searches/data?address=${address}`)
      .then(resp => setWeatherData(resp.data.data))
      .catch(err => setError(err))
      .finally(setIsLoading(false))    
  }

  const clearState = () => {
    setWeatherData(null)
    setError(null)
  }
  
  return(
    <div className='container'>
      <h1>Minimal Weather App</h1>
      <input className='search_box' type='text' placeholder='Enter Your Full Address...' onChange={e => setAddress(e.target.value)} />
      <button className='button' type='submit' onClick={submitAddress}>Submit</button>
      {loading && <div>Loading...</div>}
      {weatherData && (<WeatherData data={weatherData} />)}
      {error && <div>There was an error, please check your address and try again</div>}
    </div>
  )
}

export default Search;