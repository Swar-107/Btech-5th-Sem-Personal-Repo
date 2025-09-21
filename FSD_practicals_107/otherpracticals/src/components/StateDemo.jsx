import { Component } from "react";

class StateDemo extends Component {
  constructor() {
    super();
    this.state = {
      message: "CHARUSAT"
    };
  }
changeMessage  () {
    this.setState({ message: "CSE" });
}
  render() {
    return (
      <div>
        <h1>Welcome to -- {this.state.message}</h1>
        <button onClick={() => this.changeMessage()}>Click</button>
      </div>
    );
  }
}
export default StateDemo;