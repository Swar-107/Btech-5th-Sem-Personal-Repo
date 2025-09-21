import React, { useState, useEffect } from 'react';
import '../assets/RepCounter.css';

const RepCounter = () => {
  const [count, setCount] = useState(0);
  const [exerciseName, setExerciseName] = useState('');

  // Load from localStorage on first render
  useEffect(() => {
    const savedCount = localStorage.getItem('repCount');
    const savedExercise = localStorage.getItem('exerciseName');
    if (savedCount !== null) setCount(parseInt(savedCount, 10));
    if (savedExercise !== null) setExerciseName(savedExercise);
  }, []);

  // Save to localStorage when changed
  useEffect(() => localStorage.setItem('repCount', count), [count]);
  useEffect(() => localStorage.setItem('exerciseName', exerciseName), [exerciseName]);

  const increment = () => {
    setCount(prev => prev + 1);
  };

  const decrement = () => {
    setCount(prev => (prev > 0 ? prev - 1 : 0));
  };

  const reset = () => {
    setCount(0);
  };

  const handleExerciseChange = (e) => {
    setExerciseName(e.target.value);
  };

  return (
    <div className="counter-container">
      <header className="counter-header">
        <h1>Exercise Rep Counter</h1>
        <p>Track your workout progress</p>
      </header>

      <div className="exercise-input-section">
        <label htmlFor="exercise-name">Exercise Name:</label>
        <input
          id="exercise-name"
          type="text"
          value={exerciseName}
          onChange={handleExerciseChange}
          placeholder="e.g., Push-ups, Squats, etc."
          className="exercise-input"
        />
      </div>

      <div className="counter-display-section">
        <div className="count-display">
          <span className="count-number">{count}</span>
          <span className="count-label">reps</span>
        </div>
        {exerciseName && (
          <div className="exercise-display">
            {exerciseName}
          </div>
        )}
      </div>

      <div className="button-section">
        <button className="counter-btn decrement-btn" onClick={decrement}>
          <span>-1</span>
        </button>
        <button className="counter-btn increment-btn" onClick={increment}>
          <span>+1</span>
        </button>
      </div>

      <button className="reset-btn" onClick={reset}>
        Reset Counter
      </button>
    </div>
  );
};

export default RepCounter;
