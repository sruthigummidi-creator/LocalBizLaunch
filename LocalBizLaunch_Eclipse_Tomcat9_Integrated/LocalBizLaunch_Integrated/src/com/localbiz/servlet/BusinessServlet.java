package com.localbiz.servlet;

import com.localbiz.dao.BusinessDAO;
import com.localbiz.model.Business;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/BusinessServlet")
public class BusinessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
        try {
            List<Business> rows = new BusinessDAO().searchApproved(request.getParameter("q"));
            request.setAttribute("businesses",rows);
            request.setAttribute("searchQuery",request.getParameter("q"));
            request.getRequestDispatcher("/businesses.jsp").forward(request,response);
        } catch(SQLException e) {
            throw new ServletException("Could not load businesses. Check database connection and table columns.",e);
        }
    }

    protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
        HttpSession s=request.getSession(false);
        if(s==null || !"OWNER".equals(s.getAttribute("role"))) {
            response.sendRedirect("login.jsp?message=Please+log+in+as+a+business+owner"); return;
        }
        try {
            Business b=new Business();
            b.setOwnerId((Integer)s.getAttribute("userId"));
            b.setBusinessName(value(request,"businessName"));
            b.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            b.setAreaId(Integer.parseInt(request.getParameter("areaId")));
            b.setDescription(value(request,"description"));
            b.setStreetAddress(value(request,"streetAddress"));
            b.setPhone(value(request,"phone"));
            b.setEmail(value(request,"businessEmail"));
            b.setLogoPath(value(request,"logoPath"));
            if(b.getBusinessName().isEmpty()) {
                response.sendRedirect("owner-dashboard.jsp?message=Business+name+is+required"); return;
            }
            new BusinessDAO().create(b);
            response.sendRedirect("owner-dashboard.jsp?message=Business+submitted+for+approval");
        } catch(SQLException | NumberFormatException e) {
            throw new ServletException("Business submission failed. Verify category/area IDs and database schema.",e);
        }
    }
    private String value(HttpServletRequest r,String key) {
        String v=r.getParameter(key); return v==null?"":v.trim();
    }
}
