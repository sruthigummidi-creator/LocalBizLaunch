<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.sql.*,com.localbiz.model.Business,com.localbiz.dao.BusinessDAO,com.localbiz.util.DBConnection" %>
<%
if(session.getAttribute("userId")==null || !"OWNER".equals(session.getAttribute("role"))){response.sendRedirect("login.jsp?message=Please+log+in+as+a+business+owner");return;}
Integer ownerId=(Integer)session.getAttribute("userId");
List<Business> ownerBusinesses=new BusinessDAO().findForOwner(ownerId);
%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Owner Dashboard | LocalBiz Launch</title><link rel="stylesheet" href="style.css"><link rel="stylesheet" href="auth.css">
<style>
.dashboard-wrap{max-width:1180px;margin:45px auto;padding:0 24px}.dash-heading{display:flex;justify-content:space-between;align-items:center;gap:20px;flex-wrap:wrap;margin-bottom:26px}.dash-heading h1{font-size:36px;margin:5px 0}.dash-grid{display:grid;grid-template-columns:minmax(300px,.85fr) minmax(400px,1.15fr);gap:24px}.panel{background:#fff;border:1px solid var(--line);border-radius:14px;padding:25px;box-shadow:0 10px 30px #173f350b}.panel h2{font-size:21px;margin-bottom:8px}.panel label{display:block;font-size:12px;font-weight:700;margin:13px 0 6px}.panel input,.panel select,.panel textarea{width:100%;padding:11px;border:1px solid #dfe5dc;border-radius:7px;background:#fff}.panel button{margin-top:16px}.listing-row{border-bottom:1px solid var(--line);padding:16px 0}.listing-row:last-child{border-bottom:0}.status{font-size:11px;font-weight:700;border-radius:20px;padding:5px 9px;background:#fef3c7;color:#92400e}.status.APPROVED{background:#dcfce7;color:#166534}.status.REJECTED{background:#fee2e2;color:#991b1b}.notice-box{background:var(--sage);padding:12px;border-radius:8px;margin-bottom:18px;font-size:13px}@media(max-width:800px){.dash-grid{grid-template-columns:1fr}}
</style></head><body>
<header class="site-header"><a class="brand" href="HomeServlet"><span class="brand-mark">L<span>+</span></span><span>LocalBiz <strong>Launch</strong></span></a><nav class="main-nav"><a href="HomeServlet">Home</a><a href="BusinessServlet">Explore businesses</a></nav><div class="header-actions"><a class="btn btn-quiet" href="LogoutServlet">Log out</a></div></header>
<main class="dashboard-wrap">
<div class="dash-heading"><div><span class="eyebrow">BUSINESS OWNER WORKSPACE</span><h1>Welcome, <%=String.valueOf(session.getAttribute("fullName"))%></h1><p>Manage your local business listings and approval status.</p></div><a class="btn btn-primary" href="#add-business">＋ Add a business</a></div>
<% String message=request.getParameter("message"); if(message!=null){ %><div class="notice-box"><%=message.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")%></div><% } %>
<div class="dash-grid"><section class="panel" id="add-business"><span class="eyebrow">NEW LISTING</span><h2>Register your business</h2><p class="auth-intro">Submitted listings remain pending until an administrator approves them.</p>
<form action="BusinessServlet" method="post">
<label>Business name *</label><input name="businessName" maxlength="150" required>
<label>Category *</label><select name="categoryId" required><option value="">Choose a category</option><%try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT category_id,category_name FROM business_categories ORDER BY category_name");ResultSet r=p.executeQuery()){while(r.next()){ %><option value="<%=r.getInt(1)%>"><%=r.getString(2)%></option><%}}catch(Exception ex){%><option value="">Unable to load categories — check database</option><%}%></select>
<label>Description</label><textarea name="description" rows="3" maxlength="2000"></textarea>
<label>Street address</label><input name="streetAddress" maxlength="255">
<label>Area *</label><select name="areaId" required><option value="">Choose an area</option><%try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("SELECT area_id,area_name FROM areas ORDER BY area_name");ResultSet r=p.executeQuery()){while(r.next()){ %><option value="<%=r.getInt(1)%>"><%=r.getString(2)%></option><%}}catch(Exception ex){%><option value="">Unable to load areas — check database</option><%}%></select>
<label>Business phone</label><input name="phone" type="tel" maxlength="20">
<label>Business email</label><input name="businessEmail" type="email" maxlength="150">
<label>Logo path (optional)</label><input name="logoPath" maxlength="255" placeholder="images/my-business-logo.png">
<button class="btn btn-primary" type="submit">Submit for approval →</button>
</form></section>
<section class="panel"><span class="eyebrow">YOUR LISTINGS</span><h2>Your businesses (<%=ownerBusinesses.size()%>)</h2><p class="auth-intro">Your listing status is updated by the LocalBiz Launch admin.</p>
<%if(ownerBusinesses.isEmpty()){%><div class="listing-row"><h3>No businesses yet</h3><p>Use the form to add your first listing.</p></div><%}else{for(Business b:ownerBusinesses){%>
<div class="listing-row"><div style="display:flex;justify-content:space-between;gap:12px;align-items:start"><h3><%=b.getBusinessName()==null?"Business":b.getBusinessName().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")%></h3><span class="status <%=b.getStatus()%>"><%=b.getStatus()%></span></div><p><%=b.getCategoryName()==null?"Local business":b.getCategoryName()%> · <%=b.getAreaName()==null?"Area not set":b.getAreaName()%></p><p><%=b.getDescription()==null?"":b.getDescription()%></p><%if(b.getPhone()!=null&&!b.getPhone().isEmpty()){%><small>Phone: <%=b.getPhone()%></small><%}%></div>
<%}}%></section></div></main></body></html>
