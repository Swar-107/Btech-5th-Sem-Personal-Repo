import { Component } from "react";
import CycleA from "./CycleA";

class Parent extends Component
{
    constructor(props)
    {
        console.log("A-constructor")
        super(props)
        this.state = {
            toogle : true
        }
    }
    chngMsg()
    {
        this.setState({
            toogle : !this.state.toogle
        })
    }
    render()
    {
        return(
            <div>
                <button onClick={() => this.chngMsg()}>ToggleButton!!</button>
                {this.state.toggle && <CycleA/>}
            </div>
        )
    }
}

export default Parent