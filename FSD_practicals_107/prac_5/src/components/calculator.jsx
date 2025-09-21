import { useState } from "react";
import "../assets/calculator.css";

export default function Calculator() {
    const [display, setDisplay] = useState("0");
    const [equation, setEquation] = useState("");
    
    const handleNumber = (num) => {
        if (display === "0" || display === "Error") {
            setDisplay(num);
        } else {
            setDisplay(display + num);
        }
    };
    
    const handleOperator = (op) => {
        if (display !== "Error") {
            setEquation(display + " " + op + " ");
            setDisplay("0");
        }
    };
    
    const handleClear = () => {
        setDisplay("0");
        setEquation("");
    };
    
    const handleDelete = () => {
        if (display.length > 1) {
            setDisplay(display.slice(0, -1));
        } else {
            setDisplay("0");
        }
    };
    
    const handleEqual = () => {
        try {
            if (equation && display !== "Error") {
                const fullExpression = equation + display;
                const result = eval(fullExpression.replace(/×/g, '*').replace(/÷/g, '/'));
                setDisplay(String(result));
                setEquation("");
            }
        } catch {
            setDisplay("Error");
            setEquation("");
        }
    };
    
    return (
        <div className="calculator-container">
            <div className="calculator">
                <div className="display-section">
                    <div className="equation">{equation}</div>
                    <div className="display">{display}</div>
                </div>
                
                <div className="button-grid">
                    <div className="row operation-row">
                        <button onClick={() => handleOperator("÷")} className="op-btn">÷</button>
                        <button onClick={() => handleOperator("×")} className="op-btn">×</button>
                        <button onClick={() => handleOperator("+")} className="op-btn">+</button>
                        <button onClick={() => handleOperator("-")} className="op-btn">−</button>
                        <button onClick={handleDelete} className="del-btn">DEL</button>
                    </div>
                    
                    <div className="row">
                        <button onClick={() => handleNumber("1")} className="num-btn">1</button>
                        <button onClick={() => handleNumber("2")} className="num-btn">2</button>
                        <button onClick={() => handleNumber("3")} className="num-btn">3</button>
                    </div>
                    
                    <div className="row">
                        <button onClick={() => handleNumber("4")} className="num-btn">4</button>
                        <button onClick={() => handleNumber("5")} className="num-btn">5</button>
                        <button onClick={() => handleNumber("6")} className="num-btn">6</button>
                    </div>
                    
                    <div className="row">
                        <button onClick={() => handleNumber("7")} className="num-btn">7</button>
                        <button onClick={() => handleNumber("8")} className="num-btn">8</button>
                        <button onClick={() => handleNumber("9")} className="num-btn">9</button>
                    </div>
                    
                    <div className="row">
                        <button onClick={() => handleNumber("0")} className="num-btn">0</button>
                        <button onClick={() => handleNumber(".")} className="num-btn">.</button>
                        <button onClick={handleEqual} className="equals-btn">=</button>
                    </div>
                </div>
            </div>
        </div>
    )
}