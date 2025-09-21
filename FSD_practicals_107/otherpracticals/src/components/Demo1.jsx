// function Demo1() {
//     return <h1>Welcome</h1>
// }

const Demo1 = (props) => {
    console.log(props)
  return( 
  <div>
    <h1>Welcome to {props.dept}, {props.institute}</h1>
    {props.children}
  </div>
  )
};

export default Demo1;