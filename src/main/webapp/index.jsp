<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<br>
<a href="listadoSocios.jsp">Listado de Socios</a>
<br>
<a href="formularioSocio.jsp">Fomulario de Socio Nuevo</a>
<br>
<a href="pideNumeroSocio.jsp">Pedir Número de Socios</a>
<br>
<form method="get" action="detalleSocio.jsp">
    <p>Buscar socio mediante ID</p>
    <input type="text" name="socioID">
    <input type="submit" value="Enviar">
</form>

<br>
<h1><%= "Entrenamiento!" %></h1>
<a href="Entrenamiento/listadoEntrenamiento.jsp">Listado de Entrenamientos</a>
<br>
<a href="Entrenamiento/formularioEntrenamiento.jsp">Formulario Nuevo Entrenamiento</a>
<br>
<a href="Entrenamiento/pideNumeroEntrenamiento.jsp">Pedir Número Entrenamientos</a>
<br>

<form method="get" action="Entrenamiento/detalleEntrenamiento.jsp">
    <p>Buscar Entrenamiento mediante ID</p>
    <input type="text" name="id">
    <input type="submit" value="Enviar">
</form>

</body>
</html>