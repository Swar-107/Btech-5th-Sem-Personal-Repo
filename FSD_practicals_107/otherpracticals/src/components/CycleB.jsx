import { Component } from "react";
class CycleB extends Component 
{
    constructor(props)
    {
        console.log("B-constructor");
        super(props);
        this.state = {
            dept : "CSE"
        };
    }
    componentDidMount()
    {
        console.log("B-componentDidMount");
    }
    static getDerivedStateFromProps(props, state)
    {
        console.log("B- getDerivedStateFromProps")
        return null;
    }
    render()
    {
        return(
            <div>
                <h1>LifeCycle Methods</h1>
            </div>
        )
    }

}

export default CycleB