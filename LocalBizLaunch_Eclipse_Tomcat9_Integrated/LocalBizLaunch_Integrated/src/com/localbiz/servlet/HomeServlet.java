package com.localbiz.servlet;
import com.localbiz.dao.BusinessDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID=1L;
    protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
        try {
            request.setAttribute("businesses",new BusinessDAO().searchApproved(null));
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        } catch(Exception e) {
            // Keep the landing page accessible even when the database has not yet been configured.
            request.setAttribute("homeLoadError","Business listings are temporarily unavailable.");
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        }
    }
}
