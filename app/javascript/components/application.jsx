import * as React from 'react'
import * as ReactDOM from 'react-dom'
import Search from './Search'

const App = ({arg}) => {
    return (<div>
        Welcome to Weather App
        <Search />
    </div>)
}

document.addEventListener("DOMContentLoaded", () => {
    const rootEl = document.getElementById("root");
    ReactDOM.render(<App arg="Weather App" />, rootEl);
});