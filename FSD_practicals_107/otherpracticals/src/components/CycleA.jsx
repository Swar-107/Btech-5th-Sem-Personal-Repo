import { Component } from "react";
import CycleB from "./CycleB";
class CycleA extends Component 
{
    constructor(props)
    {
        console.log("A-constructor");
        super(props);
        this.state = {
            dept : "CSE"
        };
    }
    componentDidMount()
    {
        console.log("A-componentDidMount");
    }
    static getDerivedStateFromProps(props, state)
    {
        console.log("A- getDerivedStateFromProps")
        return null;
    }
    shouldComponentUpdate(nextProps, nextState)
    {
        console.log("A- shouldComponentUpdate")
        return true
    }
    getSnapshotBeforeUpdate(prevProps, prevState)
    {
        console.log("A- getSnapshotBeforeUpdate")
        return null
    }
    componentDidUpdate(prevProps, prevState, snapshot)
    {
        console.log("A- componentDidUpdate")
        return null
    }
    chngMsg()
    {
        this.setState({
            dept : "CSE-CSPIT"
        })
    }
    render()
    {
        console.log("A-render")
        console.log(this.state);
        return(
            <div>
                <h1>LifeCycle Methods</h1>
                <CycleB/>
            </div>
        )
    }
}

export default CycleA