import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import Demo1 from './components/Demo1'
import Demo2 from './components/Demo2'
import Demo10 from './components/Demo1'
import StateDemo from './components/StateDemo'
import CycleA from './components/CycleA'
import Parent from './components/Parent'
import HookCounter from './components/HookCounter'

function App() {
  // var a=1;
  // var b=2;
  return (
    <>
    {/* <Demo1 dept = "CSE" institute = "CSPIT"/>
    <Demo2 dept = "CE" institute = "CSPIT"/>
    <Demo10 dept = "CSE" institute = "CSPIT"/>
    <Demo2/>
    <StateDemo/>
    <CycleA/>
    <Parent/> */}
    <HookCounter/>
    </>
  )
}

export default App;