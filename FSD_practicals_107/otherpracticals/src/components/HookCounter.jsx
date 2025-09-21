import { useState } from "react";
 
const HookCounter = () => {
  const [count, setCount] = useState(0);
 
  
  const [tempFirstName, setTempFirstName] = useState("");
  const [tempLastName, setTempLastName] = useState("");
 

  const [name, setName] = useState({ firstName: "", lastName: "" });
 
  const incrementFive = () => {
    for (let i = 0; i < 5; i++) {
      setCount((prevState) => prevState + 1);
    }
  };

  const updateName = () => {
    setName({ firstName: tempFirstName, lastName: tempLastName });
  };
 
  return (
<div>
<h1>count - {count}</h1>
<button onClick={() => setCount(count + 1)}>Increment</button>
<button onClick={() => setCount(count - 1)}>Decrement</button>
<button onClick={() => setCount(0)}>Reset</button>
<button onClick={incrementFive}>Five</button>
<br />
<br />
      FirstName:{" "}
<input
        value={tempFirstName}
        onChange={(e) => setTempFirstName(e.target.value)}
      />
<br />
      LastName:{" "}
<input
        value={tempLastName}
        onChange={(e) => setTempLastName(e.target.value)}
      />
<br />
<button onClick={updateName}>Update Name</button>
<br />
<h3>FirstName: {name.firstName}</h3>
<h3>LastName: {name.lastName}</h3>
</div>
  );
};
 
export default HookCounter;