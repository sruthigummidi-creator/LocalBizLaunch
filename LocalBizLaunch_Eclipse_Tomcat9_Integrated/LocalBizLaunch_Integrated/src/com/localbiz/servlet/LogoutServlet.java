package com.localbiz.servlet;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException{
        HttpSession s=request.getSession(false);if(s!=null)s.invalidate();response.sendRedirect("index.jsp");
    }
}
