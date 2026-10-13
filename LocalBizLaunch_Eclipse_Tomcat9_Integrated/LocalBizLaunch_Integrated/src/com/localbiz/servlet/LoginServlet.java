package com.localbiz.servlet;
import com.localbiz.dao.UserDAO;import com.localbiz.model.User;import com.localbiz.util.PasswordUtil;
import javax.servlet.ServletException;import javax.servlet.annotation.WebServlet;import javax.servlet.http.*;import java.io.IOException;import java.sql.SQLException;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {private static final long serialVersionUID=1L;
 protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
  request.setCharacterEncoding("UTF-8");String email=request.getParameter("email")==null?"":request.getParameter("email").trim().toLowerCase();String password=request.getParameter("password");
  try{User u=new UserDAO().findByEmail(email);if(u==null||!PasswordUtil.verify(password,u.getPasswordHash())){response.sendRedirect("login.jsp?message=Invalid+email+or+password");return;}HttpSession s=request.getSession(true);s.setAttribute("userId",u.getUserId());s.setAttribute("fullName",u.getFullName());s.setAttribute("email",u.getEmail());s.setAttribute("role",u.getRole());switch(u.getRole()){case "ADMIN":response.sendRedirect("admin-dashboard.jsp");break;case "OWNER":response.sendRedirect("owner-dashboard.jsp");break;default:response.sendRedirect("customer-dashboard.jsp");}}
  catch(SQLException e){throw new ServletException("Login failed. Verify users columns: user_id, full_name, email, password_hash, role.",e);}
 }
}
