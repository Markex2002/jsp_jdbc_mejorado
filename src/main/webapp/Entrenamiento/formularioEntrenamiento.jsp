<%--
  Created by IntelliJ IDEA.
  User: marcom
  Date: 27/11/23
  Time: 11:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h2>Introduzca los datos del nuevo socio:</h2>
<form method="get" action="grabaEntrenamiento.jsp">
    iD entrenamiento <input type="text" name="idEntrenamiento"/></br>
    Tipo Entrenamiento <select type="text" name="tipo">
        <option value="fisico">fisico</option>
        <option value="tecnico">tecnico</option>
    </select></br>
    Ubicacion <input type="text" name="ubicacion"/></br>
    Fecha Realizacion <input type="text" name="fecha"/></br>
    <input type="submit" value="Aceptar">
</form>

<%
    String error = (String)session.getAttribute("error");
    if (error != null){
%>
<span style="background-color: red; color: yellow"> <%=error%></span>
<%
        session.removeAttribute("error");
    }
%>


</body>
</html>