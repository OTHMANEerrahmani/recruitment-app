<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>RecruttAnty - Home</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">

    </head>

    <body>
        <!-- Navigation -->
        <header>
            <nav class="container">
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <div class="logo-icon">R</div>
                    RECRUITANTY
                </a>
                <ul class="nav-links">
                    <li><a href="#employers" class="dropdown">For Employers</a></li>
                    <li><a href="#candidates" class="dropdown">For Candidates</a></li>
                    <li><a href="#about">About us</a></li>
                    <li><a href="#how">How It Works</a></li>
                    <li><a href="#contact">Contact us</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth/login" class="btn-login">Log In</a></li>
                </ul>
            </nav>
        </header>

        <!-- Hero Section -->
        <section class="hero">
            <div class="container">
                <div class="hero-content">
                    <h1>Fastest way to match people with purpose</h1>
                    <p>Connect companies with standout candidates through curated, pre-vetted introductions — not messy
                        job boards.</p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/auth/register?type=company"
                            class="btn btn-primary">Hire Talent</a>
                        <a href="${pageContext.request.contextPath}/auth/register?type=candidate"
                            class="btn btn-secondary">Find Your Role</a>
                    </div>
                </div>

                <div class="hero-visual">
                    <div class="candidate-card card-1">
                        <div class="avatar avatar-1"></div>
                        <div class="card-info">
                            <h3>Andrew Crew</h3>
                            <p>Developer</p>
                        </div>
                        <span class="badge">✓ Best fit</span>
                    </div>

                    <div class="candidate-card card-2">
                        <div class="avatar avatar-2"></div>
                        <div class="card-info">
                            <h3>Sarah Mitchell</h3>
                            <p>Account Manager</p>
                        </div>
                    </div>

                    <div class="candidate-card card-3">
                        <h3 style="margin-bottom: 0.5rem;">Financial specialist</h3>
                        <span class="star-badge">⭐ Top Match</span>
                    </div>
                </div>
            </div>
        </section>

        <!-- Trusted By Section -->
        <section class="trusted-section">
            <div class="container">
                <h3>Trusted by 100+ Companies</h3>
                <div class="company-logos">
                    <div class="company-logo">LEVER</div>
                    <div class="company-logo">gusto</div>
                    <div class="company-logo">HireVue</div>
                    <div class="company-logo">zapier</div>
                    <div class="company-logo">Glossier.</div>
                    <div class="company-logo">mailchimp</div>
                    <div class="company-logo">Buffer</div>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section" id="about">
            <div class="container">
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-number">7 days</div>
                        <div class="stat-label">Average time to fill<br>in a role</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">69%</div>
                        <div class="stat-label">Of clients return to<br>hire again</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Companies found<br>perfect hires</div>
                    </div>
                </div>

                <!-- Why Choose Us -->
                <h2 class="features-section">Why choose us?</h2>
                <div class="features-container">
                    <div class="features-grid">
                        <div class="feature">
                            <div class="feature-icon">+</div>
                            <div>
                                <h3>Transparent Hiring Process</h3>
                                <p>Real-time updates, honest feedback, clear communication at every step.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">+</div>
                            <div>
                                <h3>Future-Ready Talent Pool</h3>
                                <p>Vetted professionals with the skills and mindset to grow with you.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">+</div>
                            <div>
                                <h3>Human-Centered Matching</h3>
                                <p>We connect people to teams — based on values, not just job titles.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">+</div>
                            <div>
                                <h3>Speed Without Sacrifices</h3>
                                <p>Hire fast without cutting corners. We vet, so you don't have to.</p>
                            </div>
                        </div>
                    </div>
                    <div class="features-image">
                        👥
                    </div>
                </div>
            </div>
        </section>

        <!-- How It Works Section -->
        <section class="how-section" id="how">
            <div class="container">
                <h2>How RecruttAnty Works</h2>
                <p class="subtitle">From curated intros to faster hiring — here's how we match standout talent with
                    forward-thinking companies.</p>

                <div class="steps-grid">
                    <div class="step">
                        <div class="step-number">1</div>
                        <h3>Tell us what you need</h3>
                        <p>Share your role, goals, what makes a great hire for you.</p>
                    </div>
                    <div class="step">
                        <div class="step-number">2</div>
                        <h3>We shortlist top matches</h3>
                        <p>Every candidate is pre-vetted — no spam, no scrolling.</p>
                    </div>
                    <div class="step">
                        <div class="step-number">3</div>
                        <h3>You connect & hire fast</h3>
                        <p>Skip the job boards. Interview, decide, done.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Testimonial Section -->
        <section class="testimonial-section">
            <div class="container">
                <div class="testimonial">
                    <div class="testimonial-avatar"></div>
                    <div class="testimonial-content">
                        <blockquote>
                            We've hired faster and smarter since switching to RecruttAnty — it's like having a recruiter
                            built into our hiring process
                        </blockquote>
                        <div class="testimonial-author">Maya Lin, VP of People, SeedFlow</div>
                        <div class="testimonial-nav">
                            <button class="nav-btn">←</button>
                            <span class="page-indicator">1/5</span>
                            <button class="nav-btn">→</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Employer Alternative Section -->
        <section class="employer-hero" id="employers">
            <div class="container">
                <div class="employer-content">
                    <h1>Hire Faster, Smarter, and With Confidence</h1>
                    <p>We deliver pre-vetted candidates in days — not weeks. No job board clutter. Just great hires,
                        ready to go.</p>
                    <a href="${pageContext.request.contextPath}/auth/register?type=company"
                        class="btn btn-primary">Let's Find my Match</a>

                    <div class="process-badges">
                        <div class="process-badge badge-purple">📋 Mid-Level Content Manager</div>
                        <div class="process-badge badge-blue">🔍 Search Completed in 2 Days</div>
                        <div class="process-badge badge-orange">⚡ 12 Vetted Candidates Delivered</div>
                        <div class="process-badge badge-green">👍 Found Our Match!</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Dark Stats Section -->
        <section class="dark-section">
            <div class="container">
                <h2>Built for Teams Who Hire Smarter</h2>
                <div class="stats-visual">
                    <div class="stat-bubble bubble-1">Matched 92% of roles<br>in under 10 days</div>
                    <div class="stat-bubble bubble-2">91% satisfaction rate<br>on first candidate shortlist</div>
                    <div class="stat-bubble bubble-3">Trusted by 1,500+ hiring<br>managers globally</div>
                    <div class="stat-bubble bubble-4">We help build teams<br>in over 40 industries</div>
                    <div class="center-image"></div>
                </div>
            </div>
        </section>

    </body>

    </html>