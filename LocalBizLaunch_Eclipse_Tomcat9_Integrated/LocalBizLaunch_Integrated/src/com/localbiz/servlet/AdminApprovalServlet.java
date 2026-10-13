package com.localbiz.servlet;
import com.localbiz.dao.BusinessDAO;import javax.servlet.ServletException;import javax.servlet.annotation.WebServlet;import javax.servlet.http.*;import java.io.IOException;import java.sql.SQLException;
@WebServlet("/AdminApprovalServlet")
public class AdminApprovalServlet extends HttpServlet {private static final long serialVersionUID=1L;
 protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{HttpSession s=request.getSession(false);if(s==null||!"ADMIN".equals(s.getAttribute("role"))){response.sendError(HttpServletResponse.SC_FORBIDDEN,"Admin access required");return;}String action=request.getParameter("action");String status="approve".equals(action)?"APPROVED":"reject".equals(action)?"REJECTED":null;if(status==null){response.sendError(400,"Invalid action");return;}try{new BusinessDAO().setStatus(Integer.parseInt(request.getParameter("businessId")),status);response.sendRedirect("admin-dashboard.jsp?message=Status+updated");}catch(SQLException|NumberFormatException e){throw new ServletException("Approval failed. Verify businesses.business_id and businesses.status.",e);}}
}
