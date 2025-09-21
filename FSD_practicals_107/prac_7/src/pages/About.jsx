export default function About() {
  return (
    <div className="page-wrapper">
      <section className="content-section">
        <div className="section-header">
          <h1>About Us</h1>
          <div className="header-line"></div>
        </div>
        
        <div className="about-content">
          <div className="about-text">
            <p>
              Welcome to our website! We are passionate about creating exceptional 
              digital experiences that combine beautiful design with powerful functionality.
            </p>
            <p>
              Our team specializes in modern web development using cutting-edge technologies 
              like React, focusing on user experience and performance optimization.
            </p>
          </div>
          
          <div className="stats-grid">
            <div className="stat-item">
              <h3>5+</h3>
              <p>Years Experience</p>
            </div>
            <div className="stat-item">
              <h3>100+</h3>
              <p>Projects Completed</p>
            </div>
            <div className="stat-item">
              <h3>50+</h3>
              <p>Happy Clients</p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
