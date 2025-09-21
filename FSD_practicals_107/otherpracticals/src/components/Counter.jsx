import { Component } from 'react';
class Counter extends Component 
{
    constructor () 
    {
        super()
        this.state.count = { count: 0 }
    }
}

incr()
{
    this.state.count = this.state.count + 1
    this.setstate
    ({ 
            count: this.state.count +1 
    },
    () => {
        console.log("Callback " + this.state.count)
    })
    console.log(this.state.count)
    this.setstate((prevState) => ({
        count: prevState.count + 1
    })),
    () => {
        console.log("Callback " + this.state.count)
    }
}