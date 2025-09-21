import React from 'react'
import ReactDOM from 'react-dom/client'
import RepCounter from './components/RepCounter'
import './index.css' // optional, for global styles

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <RepCounter />
  </React.StrictMode>,
)
