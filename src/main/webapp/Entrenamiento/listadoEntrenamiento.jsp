<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%--
  Created by IntelliJ IDEA.
  User: marcom
  Date: 27/11/23
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h1>Listado de Entrenamientos</h1>
<%
    //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
    //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto","root", "user");

    //UTILIZAR STATEMENT SÓLO EN QUERIES NO PARAMETRIZADAS.
    Statement s = conexion.createStatement();
    ResultSet listado = s.executeQuery ("SELECT * FROM entrenamiento");

    while (listado.next()) {
        out.println(listado.getString("id") + " " + listado.getString ("tipoEntrenamiento") + " " + listado.getString("ubicacion") + "<br>");
    }
    listado.close();
    s.close();
    conexion.close();
%>




</body>
</html>
