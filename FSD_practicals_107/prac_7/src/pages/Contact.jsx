export default function Contact() {
  return (
    <div className="page-wrapper">
      <section className="content-section">
        <div className="section-header">
          <h1>Get In Touch</h1>
          <div className="header-line"></div>
        </div>
        
        <div className="contact-container">
          <div className="contact-info">
            <h3>Contact Information</h3>
            <div className="contact-item">
              <span className="contact-icon">📍</span>
              <p>123 Main Street, City, State 12345</p>
            </div>
            <div className="contact-item">
              <span className="contact-icon">📞</span>
              <p>+1 (555) 123-4567</p>
            </div>
            <div className="contact-item">
              <span className="contact-icon">✉️</span>
              <p>hello@mywebsite.com</p>
            </div>
          </div>
          
          <div className="contact-form">
            <h3>Send us a Message</h3>
            <form>
              <div className="form-group">
                <input type="text" placeholder="Your Name" required />
              </div>
              <div className="form-group">
                <input type="email" placeholder="Your Email" required />
              </div>
              <div className="form-group">
                <textarea placeholder="Your Message" rows="5" required></textarea>
              </div>
              <button type="submit" className="submit-btn">Send Message</button>
            </form>
          </div>
        </div>
      </section>
    </div>
  );
}
