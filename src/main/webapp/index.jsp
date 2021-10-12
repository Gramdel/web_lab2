<%@ page import="other.Point" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="hb" class="other.HistoryBean" scope="session"/>
<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8"/>
    <title>lab1</title>
    <link rel="stylesheet" href="css/style.css" type="text/css"/>
</head>
<body>

<header>
    <div id="mainHeading">
        <span>Асташин Сергей Сергеевич</span> Группа: P3230 Вариант: 30003
    </div>
</header>

<div id="content">
    <div id="flushLeft">
        <form action="controller" method="get" name="pointCheckForm">
            <div class="inputBlock">
                <b>Изменение X:</b><label><input type="checkbox" name="coordinateX" checked onclick="changeCheckBoxBehavior(this)" value="-3"/>-3</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="-2"/>-2</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="-1"/>-1</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="0"/>0</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="1"/>1</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="2"/>2</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="3"/>3</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="4"/>4</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="5"/>5</label>
            </div>
            <div class="inputBlock">
                <b>Изменение Y:</b><label data-validate="Обязательное поле"><input type="text" name="coordinateY" class="textField" pattern="(-?[0-5]\.\d*(?=[1-9])[1-9])|0|(-?[1-4])" required title="Число из промежутка (-5...5); разделитель целой и дробной части - точка (.); незначащие нули не писать!" autocomplete="off" autofocus/></label>
            </div>
            <div class="inputBlock">
                <b>Изменение R:</b>
                <label>
                    <select name="radius">
                        <%
                            for (double i = 1; i <= 3; i += 0.5) {
                               out.println("<option" + (i == 1 ? " selected " : " ") + "value=" + "\"" + i + "\">" + i + "</option>");
                            }
                        %>
                    </select>
                </label>
            </div>
            <button class="submitButton" type="submit">Отправить</button>
        </form>
    </div>
    <div id="flushRight">
        <img src="images/area.png" title="График" alt="График"/>
    </div>
    <%
        if (hb.getHistory().isEmpty()) {
            out.println("<div class='error'>История запросов пуста, поэтому таблица не загружена.</div>");
        } else {
            out.println("<table class='history'>");
            out.println("<thead><tr><th>Значение X</th><th>Значение Y</th><th>Значение R</th><th>Попадание</th><th>Дата и время</th></tr></thead>");
            out.println("<tbody>");
            for (Point p : hb.getHistory()) {
                out.println("<tr><td>" + p.getX() + "</td><td>" + p.getY() + "</td><td>" + p.getR() + "</td><td>" + (p.isInArea() ? "Да" : "Нет") + "</td><td>" + (new SimpleDateFormat("dd.MM.yy HH:mm:ss")).format(p.getDate()) + "</td></tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        }
    %>
    <a href="#mainHeading" id="scrollUpButton" title="Наверх" hidden>?</a>
</div>
</body>
</html>
<script>
    window.addEventListener('scroll', function() {
        document.getElementById('scrollUpButton').hidden = scrollY < 30;
    });
</script>