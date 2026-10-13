<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,com.localbiz.model.Business" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Discover local businesses or bring your business online with LocalBiz Launch.">
  <title>LocalBiz Launch | Discover Local. Grow Local.</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header class="site-header">
    <a class="brand" href="HomeServlet" aria-label="LocalBiz Launch home"><span class="brand-mark">L<span>+</span></span><span>LocalBiz <strong>Launch</strong></span></a>
    <button class="menu-toggle" id="menuToggle" aria-label="Toggle navigation" aria-expanded="false">☰</button>
    <nav class="main-nav" id="mainNav"><a class="active" href="#home">Home</a><a href="#explore">Explore businesses</a><a href="#how-it-works">How it works</a><a href="#for-owners">For owners</a></nav>
    <div class="header-actions"><a class="btn btn-quiet" href="login.jsp">Log in</a><a class="btn btn-primary btn-small" href="register.jsp">Get started <span>↗</span></a></div>
  </header>
  <main>
    <section class="hero" id="home">
      <div class="hero-orb orb-one"></div><div class="hero-orb orb-two"></div>
      <div class="hero-copy"><div class="eyebrow"><span class="eyebrow-dot"></span> YOUR COMMUNITY, CONNECTED</div><h1>Discover local.<br><span>Grow local.</span></h1><p class="hero-lede">Find the people behind your favourite local businesses—or give your own business a place to shine online.</p><div class="hero-actions"><a class="btn btn-primary btn-large" href="#explore">Explore businesses <span>→</span></a><a class="btn btn-outline btn-large" href="register.jsp?role=OWNER">List your business <span>↗</span></a></div><div class="hero-proof"><div class="avatar-stack" aria-hidden="true"><span>🍰</span><span>🧵</span><span>🥭</span><span>🌿</span></div><div><strong>Made for local makers</strong><small>Small businesses. Big possibilities.</small></div></div></div>
      <div class="hero-visual" aria-label="Illustration of a local shop"><div class="floating-note note-top"><span class="note-icon">✦</span><div><strong>Made nearby</strong><small>Find something special</small></div></div><div class="shop-window"><div class="shop-awning"><span></span><span></span><span></span><span></span><span></span><span></span></div><div class="shop-sign">the little<br><em>market</em></div><div class="shop-front"><div class="shop-window-pane"><span class="plant">✿</span><span class="jar">▥</span><span class="plant">✿</span></div><div class="shop-door"><div class="door-knob"></div></div></div><div class="shop-step"></div></div><div class="floating-note note-bottom"><span class="pin-icon">⌖</span><div><strong>Right around you</strong><small>Explore your area or beyond</small></div></div><div class="hero-spark spark-one">✳</div><div class="hero-spark spark-two">✦</div></div>
      <div class="hero-bottom-label"><span>01</span> A BETTER WAY TO SHOP LOCAL</div>
    </section>
    <section class="search-section" id="explore"><div class="section-heading compact-heading"><div><span class="eyebrow">START EXPLORING</span><h2>What are you looking for?</h2></div><p>Good things are closer than you think.</p></div>
      <form class="search-bar" id="searchForm"><label class="search-field search-keyword"><span class="field-icon">⌕</span><span class="field-content"><small>I'm looking for</small><input id="keywordInput" type="search" placeholder="Cakes, handmade gifts, boutiques..." aria-label="Search businesses or products"></span></label><span class="search-divider"></span><label class="search-field"><span class="field-icon location-icon">⌖</span><span class="field-content"><small>Location</small><input id="locationInput" type="text" placeholder="City or area" aria-label="City or area"></span></label><button class="btn btn-primary search-submit" type="submit">Find businesses <span>→</span></button></form>
      <div class="search-hint"><span>↳</span> Try “homemade pickles” or “cakes in Bhimavaram”. Listings are loaded from the LocalBiz Launch database.</div><p class="search-status" id="searchStatus" aria-live="polite"></p>
    </section>
    <section class="categories section-pad"><div class="section-heading"><div><span class="eyebrow">A LITTLE BIT OF EVERYTHING</span><h2>Explore by category</h2></div><a class="text-link" href="#businesses">Browse all categories <span>→</span></a></div>
      <div class="category-grid"><button class="category-card category-peach" data-category="Bakery & Cakes"><span class="category-art">🍰</span><span class="category-name">Bakery & cakes</span><span class="category-meta">Sweeten your day <b>↗</b></span></button><button class="category-card category-green" data-category="Food & Homemade Products"><span class="category-art">🥭</span><span class="category-name">Homemade food</span><span class="category-meta">Made with care <b>↗</b></span></button><button class="category-card category-blue" data-category="Clothing & Fashion"><span class="category-art">🧵</span><span class="category-name">Clothing & fashion</span><span class="category-meta">Find your style <b>↗</b></span></button><button class="category-card category-lilac" data-category="Handmade Products"><span class="category-art">🪴</span><span class="category-name">Handmade finds</span><span class="category-meta">One of a kind <b>↗</b></span></button></div>
    </section>
    <section class="business-section section-pad" id="businesses"><div class="section-heading"><div><span class="eyebrow">GOOD PEOPLE, GREAT FINDS</span><h2>Meet local favourites</h2><p class="section-subtitle">A preview of the kinds of businesses you’ll discover here.</p></div><span class="sample-label"><span></span> Approved listings</span></div>
      <div class="business-grid" id="businessGrid">
        <%
          List<Business> homepageBusinesses = (List<Business>) request.getAttribute("businesses");
          if (homepageBusinesses != null && !homepageBusinesses.isEmpty()) {
            for (Business b : homepageBusinesses) {
              String nm = b.getBusinessName() == null ? "Local business" : b.getBusinessName();
              String cat = b.getCategoryName() == null ? "Local Business" : b.getCategoryName();
              String desc = b.getDescription() == null ? "Discover this local business." : b.getDescription();
              String area = b.getAreaName() == null ? "Local area" : b.getAreaName();
              String searchable = (nm+" "+cat+" "+desc+" "+area+" "+(b.getStreetAddress()==null?"":b.getStreetAddress())).toLowerCase();
              String safeNm = nm.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
              String safeCat = cat.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
              String safeDesc = desc.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
              String safeArea = area.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
              String safeSearch = searchable.replace("\"","&quot;");
        %>
          <article class="business-card" data-category="<%=safeCat%>" data-search="<%=safeSearch%>">
            <div class="business-image pantry-image"><span class="image-tag"><%=safeCat.toUpperCase()%></span><div class="food-illustration">🏪</div><span class="image-sun"></span></div>
            <div class="business-info">
              <div class="business-title-row"><h3><%=safeNm%></h3><span class="business-arrow">↗</span></div>
              <p><%=safeDesc%></p>
              <div class="business-meta"><span>⌖ <%=safeArea%></span><span class="open-tag">Approved</span></div>
              <a href="BusinessServlet?q=<%=java.net.URLEncoder.encode(nm, "UTF-8")%>" class="card-link">View business <span>→</span></a>
            </div>
          </article>
        <% } } else { %>
          <article class="business-card"><div class="business-image bakery-image"><span class="image-tag">LOCAL</span><div class="food-illustration">🏪</div></div><div class="business-info"><h3>Be the first to explore</h3><p>Approved local business listings will appear here after the database is connected and owners are approved.</p><a href="register.jsp?role=OWNER" class="card-link">List your business <span>→</span></a></div></article>
        <% } %>
      </div><p class="no-results" id="noResults" hidden>No approved businesses match your search. Try another keyword or category.</p>    </section>
    <section class="how-section section-pad" id="how-it-works"><div class="section-heading"><div><span class="eyebrow">SIMPLE BY DESIGN</span><h2>Local connections, made easy</h2></div><p>Less searching. More supporting the people around you.</p></div><div class="steps-grid"><article class="step-card"><span class="step-number">01</span><span class="step-icon">⌕</span><h3>Find your kind of local</h3><p>Search by product, category, city or area to discover businesses that fit what you need.</p></article><article class="step-card"><span class="step-number">02</span><span class="step-icon">♡</span><h3>Explore their story</h3><p>Browse a business profile, see its products and reach out to the people who make them.</p></article><article class="step-card"><span class="step-number">03</span><span class="step-icon">↗</span><h3>Help local businesses grow</h3><p>Support independent makers and help great local work reach more customers.</p></article></div></section>
    <section class="owner-banner section-pad" id="for-owners"><div class="owner-banner-art"><span class="banner-circle circle-a"></span><span class="banner-circle circle-b"></span><span class="banner-shop">✿</span><span class="banner-spark">✦</span></div><div class="owner-banner-copy"><span class="eyebrow eyebrow-light">YOUR BUSINESS DESERVES TO BE SEEN</span><h2>Big dreams can start<br>right where you are.</h2><p>Set up your business profile, showcase your products and get a simple website made for your brand—all in one place.</p><a class="btn btn-gold btn-large" href="register.jsp?role=OWNER">Bring your business online <span>→</span></a></div></section>
    <section class="closing-note"><span class="closing-star">✳</span><p>Every big thing starts somewhere.<br><strong>Let’s make local the place to start.</strong></p><a href="#home" class="back-top">Back to top ↑</a></section>
  </main>
  <footer class="site-footer"><a class="brand footer-brand" href="HomeServlet"><span class="brand-mark">L<span>+</span></span><span>LocalBiz <strong>Launch</strong></span></a><p>Helping local businesses find their next customer.</p><div class="footer-links"><a href="#explore">Explore</a><a href="#how-it-works">How it works</a><a href="#for-owners">For owners</a><a href="login.jsp">Log in</a></div><small>© 2026 LocalBiz Launch · Student project demo. Listings shown are sample data.</small></footer>
  <script src="script.js"></script>
</body>
</html>
