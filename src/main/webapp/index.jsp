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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <style>
        @font-face {
            font-family: fantasy;
            src: url(fonts/impact.ttf) format("truetype");
            font-style: normal;
            font-weight: normal;
        }
        #mainHeading {
            width: 756px;
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            color: #114da4;
            font-family: fantasy;
            font-size: 23pt;
        }
        #mainHeading::selection {
            color: white;
            background-color: #114da4;
        }
        #mainHeading span {
            color: #4a98ff;
            font-size: 23pt;
        }
        #mainHeading span::selection {
            color: white;
            background-color: #4a98ff;
        }
    </style>
</head>
<body>

<header>
    <div id="mainHeading">
        <span>Асташин Сергей Сергеевич</span> Группа: P3230 Вариант: 30003
    </div>
</header>

<div id="content">
    <div id="flushLeft">
        <form action="controller" method="get" id="pointCheckForm">
            <div class="inputBlock">
                <b>Изменение X:</b>
                <label data-validate="Обязательное поле">
                    <input type="text" id="hiddenField" required name="coordinateX" style="display: none;"/>
                </label>
                <%
                    for (int i = -4; i <= 4; i++) {
                        out.println("<button class=\"xButton\" type=\"button\" onclick=\"setX("+i+")\">" + i + "</button>");
                    }
                %>
            </div>
            <div class="inputBlock">
                <b>Изменение Y:</b><label data-validate="Обязательное поле"><input type="text" name="coordinateY" class="textField" pattern="(-?[0-5]\.\d*(?=[1-9])[1-9])|0|(-?[1-4])" required title="Число из промежутка (-5...5); разделитель целой и дробной части - точка (.); незначащие нули не писать!" autocomplete="off" autofocus/></label>
            </div>
            <div class="inputBlock">
                <b>Изменение R:</b>
                <label>
                    <select class="rSelect" name="radius" onchange="drawArea(this.value)">
                        <%
                            for (double i = 1; i <= 3; i += 0.5) {
                               out.println("<option" + (i == 3 ? " selected " : " ") + "value=" + "\"" + i + "\">" + i + "</option>");
                            }
                        %>
                    </select>
                </label>
            </div>
            <button class="submitButton" type="submit">Отправить</button>
        </form>
    </div>
    <div id="flushRight">
        <canvas width="264" height="264" id="canvas"></canvas>
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
    <a href="#mainHeading" id="scrollUpButton" title="Наверх" hidden>↑</a>
</div>
</body>
</html>
<script>
    function setX(value) {
        document.getElementById('hiddenField').value = value;
    }

    window.addEventListener('scroll', function() {
        document.getElementById('scrollUpButton').hidden = scrollY < 30;
    });

    let canvas = document.getElementById('canvas');
    canvas.addEventListener('mouseup', function (e) {
        let x = ((e.pageX - e.target.offsetLeft - 133)/36+0.01).toFixed(1);
        let y = ((e.pageY - e.target.offsetTop - 133)/-36+0.005).toFixed(1);
        console.log("x = "+x);
        console.log("y = "+y);
        console.log(" ");
    });

    function drawArea(r) {
        let ctx = canvas.getContext('2d');

        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = "black";
        ctx.lineWidth = 1;

        ctx.beginPath(); // оси
        ctx.moveTo(132.5, 0);
        ctx.lineTo(132.5, 264);
        ctx.moveTo(128, 6);
        ctx.lineTo(132.5, 0);
        ctx.moveTo(137, 6);
        ctx.lineTo(132.5, 0);
        ctx.moveTo(0, 132.5);
        ctx.lineTo(264, 132.5);
        ctx.moveTo(258, 137);
        ctx.lineTo(264, 132.5);
        ctx.moveTo(258, 128);
        ctx.lineTo(264, 132.5);
        ctx.stroke();

        ctx.font = "11pt Calibri";
        ctx.fillText("Y", 120, 11);
        ctx.fillText("X", 255, 148);

        ctx.fillStyle = "#4a98ff";
        ctx.fillRect(132.5-r*18-1.5, 133, r*18+1, r*18*2+1); // прямоугольник

        ctx.beginPath(); // треугольник
        ctx.moveTo(133, 132);
        ctx.lineTo(133+r*18+1.5, 132);
        ctx.lineTo(133, 132-r*18);
        ctx.lineTo(133, 132);
        ctx.fill();

        ctx.beginPath(); // круг
        ctx.arc(131.5, 132, r*18, -Math.PI/2, -Math.PI, true);
        ctx.lineTo(132, 132);
        ctx.lineTo(132, 132-r*18);
        ctx.fill();

        for(let i = 1; i <= 6; i++) {
            ctx.beginPath();
            ctx.moveTo(132.5+i*18+1, 130); // насечки по x вправо
            ctx.lineTo(132.5+i*18+1, 135);
            ctx.moveTo(132.5-i*18-1, 130); // насечки по x влево
            ctx.lineTo(132.5-i*18-1, 135);
            ctx.moveTo(130, 132.5+i*18+1); // насечки по y вниз
            ctx.lineTo(135, 132.5+i*18+1);
            ctx.moveTo(130, 132.5-i*18-1); // насечки по y вверх
            ctx.lineTo(135, 132.5-i*18-1);
            ctx.stroke();
        }

        ctx.fillStyle = "black";

        ctx.fillText("R", 120, 132.5-r*18*2+2); // R по y
        if (r !== "1.0") {
            ctx.fillText("0.5R", 120-19, 132.5-r*18+2);
            ctx.fillText("0.5R", 120-19, 132.5+r*18+4);
        }
        ctx.fillText("R", 120, 132.5+r*18*2+4);

        ctx.fillText("R", 132.5-r*18*2-5, 148); // R по x
        if (r !== "1.0") {
            ctx.fillText("0.5R", 132.5 - r * 18 - 10, 148);
            ctx.fillText("0.5R", 132.5 + r * 18 - 8, 148);
        }
        ctx.fillText("R", 132.5 + r * 18 * 2 - 3, 148);
    }
    drawArea(3);

</script>