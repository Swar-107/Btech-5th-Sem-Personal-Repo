import { useState } from "react";
import "../assets/todo.css";

export default function TodoApp() {
  const [tasks, setTasks] = useState(["Task 1", "Task 2"]);
  const [newTask, setNewTask] = useState("");
  const [editingIndex, setEditingIndex] = useState(null);
  const [editingText, setEditingText] = useState("");

  const addTask = () => {
    if (newTask.trim() === "") return;
    setTasks([...tasks, newTask]);
    setNewTask("");
  };

  const deleteTask = (index) => {
    setTasks(tasks.filter((_, i) => i !== index));
  };

  const startEditing = (index) => {
    setEditingIndex(index);
    setEditingText(tasks[index]);
  };

  const saveEdit = () => {
    if (editingText.trim() === "") return;
    const updatedTasks = [...tasks];
    updatedTasks[editingIndex] = editingText;
    setTasks(updatedTasks);
    setEditingIndex(null);
    setEditingText("");
  };

  const cancelEdit = () => {
    setEditingIndex(null);
    setEditingText("");
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      addTask();
    }
  };

  const handleEditKeyPress = (e) => {
    if (e.key === 'Enter') {
      saveEdit();
    } else if (e.key === 'Escape') {
      cancelEdit();
    }
  };

  return (
    <div className="todo-container">
      <h1 className="app-title">No need to remember things jot them here !</h1>

      <div className="input-section">
        <input
          type="text"
          placeholder="What is the task today?"
          value={newTask}
          onChange={(e) => setNewTask(e.target.value)}
          onKeyPress={handleKeyPress}
          className="task-input"
        />
        <button onClick={addTask} className="add-btn">Add Task</button>
      </div>

      <div className="task-list">
        {tasks.map((task, index) => (
          <div key={index} className="task-item">
            {editingIndex === index ? (
              <div className="edit-mode">
                <input
                  type="text"
                  value={editingText}
                  onChange={(e) => setEditingText(e.target.value)}
                  onKeyPress={handleEditKeyPress}
                  className="edit-input"
                  autoFocus
                />
                <div className="edit-buttons">
                  <button className="save-btn" onClick={saveEdit}>Save</button>
                  <button className="cancel-btn" onClick={cancelEdit}>Cancel</button>
                </div>
              </div>
            ) : (
              <>
                <span className="task-text">{task}</span>
                <div className="task-actions">
                  <button 
                    className="edit-btn" 
                    onClick={() => startEditing(index)}
                    title="Edit task"
                  >
                    ✏️
                  </button>
                  <button 
                    className="delete-btn" 
                    onClick={() => deleteTask(index)}
                    title="Delete task"
                  >
                    🗑️
                  </button>
                </div>
              </>
            )}
          </div>
        ))}
        
        {tasks.length === 0 && (
          <div className="empty-state">
            <p>No tasks yet. Add one above!</p>
          </div>
        )}
      </div>
    </div>
  );
}
