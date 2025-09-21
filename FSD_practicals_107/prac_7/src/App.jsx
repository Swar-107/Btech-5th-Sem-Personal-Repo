import { useState } from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import Sidebar from "./components/Sidebar";
import Home from "./pages/Home";
import About from "./pages/About";
import Contact from "./pages/Contact";
import "./assets/sidebar.css";

export default function App() {
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);
  const toggleSidebar = () => setIsSidebarOpen(!isSidebarOpen);
  const closeSidebar = () => setIsSidebarOpen(false);

  return (
    <Router>
      <div className="app-layout">
        {/* Navigation Bar */}
        <nav className="navbar">
          <div className="nav-brand">
            <h2>My Portfolio</h2>
          </div>
          
          {/* Desktop Navigation */}
          <div className="nav-links desktop-nav">
            <Link to="/">Home</Link>
            <Link to="/about">About</Link>
            <Link to="/contact">Contact</Link>
          </div>
          
          {/* Mobile Menu Button */}
          <button 
            className="mobile-menu-btn" 
            onClick={toggleSidebar}
            aria-label="Toggle navigation menu"
          >
            <span className={`hamburger ${isSidebarOpen ? 'active' : ''}`}>
              <span></span>
              <span></span>
              <span></span>
            </span>
          </button>
        </nav>

        {/* Mobile Sidebar Overlay */}
        {isSidebarOpen && (
          <div className="sidebar-overlay" onClick={closeSidebar}></div>
        )}

        {/* Sidebar Component */}
        <Sidebar 
          isOpen={isSidebarOpen} 
          toggleSidebar={toggleSidebar}
          closeSidebar={closeSidebar}
        />

        {/* Main Content Area */}
        <main className="main-container">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/about" element={<About />} />
            <Route path="/contact" element={<Contact />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}
