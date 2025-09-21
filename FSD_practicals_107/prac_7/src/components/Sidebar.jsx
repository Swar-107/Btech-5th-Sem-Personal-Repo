import { Link, useLocation } from "react-router-dom";
import "../assets/sidebar.css";

export default function Sidebar({ isOpen, closeSidebar }) {
  const location = useLocation();

  const navigationItems = [
    { path: "/", label: "Home", icon: "🏠" },
    { path: "/about", label: "About", icon: "👤" },
    { path: "/contact", label: "Contact", icon: "📧" }
  ];

  return (
    <aside className={`sidebar ${isOpen ? "sidebar-open" : ""}`}>
      <div className="sidebar-header">
        <h3>Navigation</h3>
        <button 
          className="close-btn" 
          onClick={closeSidebar}
          aria-label="Close navigation menu"
        >
          ✕
        </button>
      </div>
      
      <nav className="sidebar-nav">
        {navigationItems.map((item) => (
          <Link
            key={item.path}
            to={item.path}
            onClick={closeSidebar}
            className={`nav-item ${location.pathname === item.path ? 'active' : ''}`}
          >
            <span className="nav-icon">{item.icon}</span>
            <span className="nav-label">{item.label}</span>
          </Link>
        ))}
      </nav>
      
      <div className="sidebar-footer">
        <p>&copy; 2025 My Portfolio</p>
      </div>
    </aside>
  );
}
