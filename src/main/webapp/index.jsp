<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8"/>
    <title>lab1</title>
    <style>
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
        #content {
            width: 756px;
            margin-top: 40px;
            margin-left: auto;
            margin-right: auto;
            font-family: "Calibri", sans-serif;
            font-size: large;
        }
        #content div {
            margin-bottom: 3%;
        }
        .inputBlock {
            font-size: larger;
            font-style: italic;
        }
        .submitButton {
            font-family: "Calibri Light", sans-serif;
            width: 548px;
            height: 45px;
            padding-bottom: 3px;
            font-size: 16pt;
            margin-top: 0.5%;
            cursor: pointer;
        }
        input {
            margin-left: 3.22%;
        }
        .textField {
            height: 18pt;
            margin-left: 2.7%;
            width: 400px;
            font-size: 16pt;
            font-style: italic;
            font-family: 'Calibri', sans-serif;
        }
        .textField:invalid {
            color: red;
        }
        .history {
            width: 756px;
            border-collapse: collapse;
            font-size: 15pt;
            margin: 0 auto 12px;
        }
        .history td {
            border: 1px solid rgb(118, 118, 118);
            padding-left: 6px;
            padding-right: 6px;
        }
        .history th {
            border: 1px solid rgb(118, 118, 118);
            padding-left: 6px;
            padding-right: 6px;
        }
        #flushLeft {
            width: 550px;
            float: left;
        }
        #flushRight {
            margin-left: 558px;
        }
        .error {
            background-color: #ffe3e3;
            width: 756px;
            margin-left: auto;
            margin-right: auto;
            font-size: 16pt;
            font-weight: bold;
            border-radius: 3px;
            border: 1px solid darkred;
            text-align: center;
            color: darkred;
            height: 50px;
            padding-top: 20px;
            padding-bottom: 0;
        }
        #scrollUpButton {
            display: block;
            text-align: center;
            text-decoration: none;
            font-family: "Calibri Light", sans-serif;
            font-weight: bold;
            font-size: 15pt;
            color: white;
            border: 0;
            width: 40px;
            height: 40px;
            border-radius: 20px;
            background-color: #4a98ff;
            line-height: 36px;
            position: sticky;
            bottom: 10px;
            margin-left: -49px;
            margin-top: -50px;
        }
        #scrollUpButton:hover {
            box-shadow: 0 1px 10px 2px rgba(17, 77, 164, 0.6);
        }
        #scrollUpButton:active {
            background-color: #114da4;
            cursor: none;
        }
        #scrollUpButton[hidden] {
            display: none;
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
        <form action="core.php" method="post" name="pointCheckForm">
            <div class="inputBlock">
                <b>Изменение X:</b><label><input type="checkbox" name="coordinateX" checked onclick="changeCheckBoxBehavior(this)" value="-3"/>-3</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="-2"/>-2</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="-1"/>-1</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="0"/>0</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="1"/>1</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="2"/>2</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="3"/>3</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="4"/>4</label><label><input type="checkbox" name="coordinateX" onclick="changeCheckBoxBehavior(this)" value="5"/>5</label>
            </div>
            <div class="inputBlock">
                <b>Изменение Y:</b><label data-validate="Обязательное поле"><input type="text" name="coordinateY" class="textField" pattern="(-?[0-2]\.\d*(?=[1-9])[1-9])|0|(-?[12])" required title="Число из промежутка (-3...3); разделитель целой и дробной части - точка (.); незначащие нули не писать!" autocomplete="off" autofocus/></label>
            </div>
            <div class="inputBlock">
                <b>Изменение R:</b><label><input type="checkbox" name="radius" checked onclick="changeCheckBoxBehavior(this)" value="1"/>1</label><label><input type="checkbox" name="radius" onclick="changeCheckBoxBehavior(this)" value="1.5"/>1.5</label><label><input type="checkbox" name="radius" onclick="changeCheckBoxBehavior(this)" value="2"/>2</label><label><input type="checkbox" name="radius" onclick="changeCheckBoxBehavior(this)" value="2.5"/>2.5</label><label><input type="checkbox" name="radius" onclick="changeCheckBoxBehavior(this)" value="3"/>3</label>
            </div>
            <button class="submitButton" type="submit">Отправить</button>
        </form>
    </div>
    <div id="flushRight">
        <img src="images/area.png" title="График" alt="График"/>
    </div>
    <?php
        if (isset($_SESSION['rows']))
        {
            echo "<table class='history'>";
            echo "<thead><tr><th>Значение X</th><th>Значение Y</th><th>Значение R</th><th>Попадание</th><th>Дата и время</th><th>Длительность</th></tr></thead>";
            echo "<tbody>";
            foreach ($_SESSION['rows'] as $row)
            {
                echo $row;
            }
            echo "</tbody>";
            echo "</table>";
        }
        else
        {
            echo "<div class='error'>История запросов пуста, поэтому таблица не загружена.</div>";
        }
    ?>
    <a href="#mainHeading" id="scrollUpButton" title="Наверх" hidden>?</a>
</div>
</body>
</html>
<script>
    function changeCheckBoxBehavior(element)
    {
        let checkboxes = document.getElementsByName(element.name);
        for (let i = 0; i < checkboxes.length; i++)
        {
            checkboxes[i].checked = false;
        }
        element.checked = true;
    }

    window.addEventListener('scroll', function() {
        document.getElementById('scrollUpButton').hidden = scrollY < 30;
    });
</script>