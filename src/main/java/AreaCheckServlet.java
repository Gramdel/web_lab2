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

            resp.sendRedirect("index.jsp");
        }
    }
}