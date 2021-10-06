import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");

        String coordinateX = req.getParameter("coordinateX");
        String coordinateY = req.getParameter("coordinateY");
        String radius = req.getParameter("radius");

        if (coordinateX == null || coordinateY == null || radius == null) {
            resp.getWriter().print("Ошибка: один или несколько передаваемых праматеров не указаны!");
            resp.getWriter().close();
        } else {
            try {
                int x = Integer.parseInt(coordinateX);
                double y = Double.parseDouble(coordinateY);
                double r = Double.parseDouble(radius);

                ArrayList<Integer> allowedX = new ArrayList<>();
                for (int i = -4; i <= 4; i++) {
                    allowedX.add(i);
                }
                ArrayList<Double> allowedR = new ArrayList<>();
                for (double i = 1; i <= 3; i += 0.5) {
                    allowedR.add(i);
                }

                String error = "";
                if (!allowedX.contains(x)) {
                    error += "Ошибка в формате координаты x! Допустимые значения: все целые числа от -4 до 4 включительно</br>";
                }
                if (y <= -5 || y >= 5) {
                    error += "Ошибка в формате координаты y! Допустимые значения: все числа из промежутка (-5...5)</br>";
                }
                if (!allowedR.contains(r)) {
                    error += "Ошибка в формате радиуса! Допустимые значения: все числа от 1 до 3 включительно с шагом 0.5</br>";
                }

                if (error.isEmpty()) {
                    req.setAttribute("x", x);
                    req.setAttribute("y", y);
                    req.setAttribute("r", r);
                    RequestDispatcher requestDispatcher = req.getRequestDispatcher("/check");
                    requestDispatcher.forward(req, resp);
                } else {
                    resp.getWriter().print(error);
                    resp.getWriter().close();
                }
            } catch (NumberFormatException e) {
                resp.getWriter().print("Ошибка в формате: один или несколько переданных параметров не являются числом!");
                resp.getWriter().close();
            }
        }
    }
}