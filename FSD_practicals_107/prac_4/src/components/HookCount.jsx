import React, { useState } from 'react';
import './HookCount.css';

const HookCount = () => {
    const [count, setCount] = useState(0);
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');

    const incrementFive = () => {
        setCount(prevCount => prevCount + 5);
    };

    return (
        <div className="app-container">
            <div className="counter-section">
                <h1 className="count-display">Count: {count}</h1>
                <div className="button-group">
                    <button className="counter-btn" onClick={() => setCount(0)}>Reset</button>
                    <button className="counter-btn" onClick={() => setCount(count + 1)}>Increment</button>
                    <button className="counter-btn" onClick={() => setCount(count - 1)}>Decrement</button>
                    <button className="counter-btn" onClick={incrementFive}>Increment 5</button>
                </div>
            </div>
            
            <div className="name-section">
                <h1 className="welcome-title">Welcome to CHARUSAT!!!</h1>
                <div className="input-section">
                    <div className="input-row">
                        <label>First Name:</label>
                        <input 
                            type="text" 
                            value={firstName} 
                            onChange={e => setFirstName(e.target.value)} 
                        />
                    </div>
                    <div className="input-row">
                        <label>Last Name:</label>
                        <input 
                            type="text" 
                            value={lastName} 
                            onChange={e => setLastName(e.target.value)} 
                        />
                    </div>
                </div>
                <div className="output-section">
                    <p>First Name: {firstName}</p>
                    <p>Last Name: {lastName}</p>
                </div>
            </div>
        </div>
    );
};

export default HookCount;