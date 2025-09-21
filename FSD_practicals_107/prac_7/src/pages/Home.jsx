export default function Home() {
  return (
    <div className="page-wrapper">
      <section className="hero-section">
        <div className="hero-content">
          <h1 className="hero-title">Welcome to My Website</h1>
          <p className="hero-subtitle">
            This is the main content of the webpage. Discover amazing content and navigate 
            through different sections using the menu.
          </p>
          <div className="feature-cards">
            <div className="feature-card">
              <h3>Modern Design</h3>
              <p>Clean and professional interface</p>
            </div>
            <div className="feature-card">
              <h3>Responsive</h3>
              <p>Works great on all devices</p>
            </div>
            <div className="feature-card">
              <h3>Fast Loading</h3>
              <p>Optimized for performance</p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
