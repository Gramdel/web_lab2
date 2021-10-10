package servlets;

import beans.HistoryBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");

        if (req.getAttribute("x") == null || req.getAttribute("y") == null || req.getAttribute("r") == null) {
            resp.getWriter().print("Доступ запрещён!");
            resp.getWriter().close();
        } else {
            int x = (Integer) req.getAttribute("x");
            double y = (Double) req.getAttribute("y");
            double r = (Double) req.getAttribute("r");

            if (pointIsInTriangle(x, y, r) || pointIsInCircle(x, y, r) || pointIsInRectangle(x, y, r)) {
                HistoryBean hb = (HistoryBean) req.getSession().getAttribute("hb");
                hb.getHistory().add(x + "; " + y + "; " + r + "; " + "yes");
                req.getSession().setAttribute("hb", hb);
            } else {
                HistoryBean hb = (HistoryBean) req.getSession().getAttribute("hb");
                hb.getHistory().add(x + "; " + y + "; " + r + "; " + "no");
                req.getSession().setAttribute("hb", hb);
            }

            resp.sendRedirect("index.jsp");
        }
    }

    private boolean pointIsInTriangle(int x, double y, double r) {
        return (y <= r/2 - x) && (y >= 0) && (x >= 0);
    }

    private boolean pointIsInCircle(int x, double y, double r) {
        return (x*x + y*y <= r*r/4) && (y >= 0) && (x <= 0);
    }

    private boolean pointIsInRectangle(int x, double y, double r) {
        return (y >= -r) && (y <= 0) && (x >= -r / 2) && (x <= 0);
    }
}