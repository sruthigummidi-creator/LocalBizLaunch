package com.localbiz.servlet;
import com.localbiz.dao.UserDAO;import com.localbiz.model.User;import com.localbiz.util.PasswordUtil;
import javax.servlet.ServletException;import javax.servlet.annotation.WebServlet;import javax.servlet.http.*;import java.io.IOException;import java.sql.SQLException;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {private static final long serialVersionUID=1L;
 protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
  request.setCharacterEncoding("UTF-8");String name=trim(request.getParameter("fullName"));String email=trim(request.getParameter("email")).toLowerCase();String password=request.getParameter("password");String role=trim(request.getParameter("role"));
  if(name.length()<2||email.isEmpty()||password==null||password.length()<8||(!"CUSTOMER".equals(role)&&!"OWNER".equals(role))){response.sendRedirect("register.jsp?message=Please+check+your+details+and+use+a+password+of+at+least+8+characters");return;}
  try{UserDAO dao=new UserDAO();if(dao.emailExists(email)){response.sendRedirect("register.jsp?message=An+account+with+this+email+already+exists");return;}User u=new User();u.setFullName(name);u.setEmail(email);u.setPhone(trim(request.getParameter("phone")));u.setPasswordHash(PasswordUtil.hash(password));u.setRole(role);dao.create(u);response.sendRedirect("login.jsp?message=Registration+successful");}
  catch(SQLException e){throw new ServletException("Registration failed. Verify users columns: user_id, full_name, email, password_hash, role.",e);}
 }
 private String trim(String s){return s==null?"":s.trim();}
}
