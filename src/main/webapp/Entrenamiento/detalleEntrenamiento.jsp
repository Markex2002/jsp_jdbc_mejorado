<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: marcom
  Date: 27/11/23
  Time: 11:51
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int numero = -1;

    try {
        numero = Integer.parseInt(request.getParameter("id"));

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("id"));
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("id").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;
    }



    String sql = "SELECT * FROM entrenamiento WHERE id = ?";
    ResultSet listado = null;
    PreparedStatement ps = null;
    Connection conexion = null;

    if (valida){
        //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
        //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto","root", "user");

        //UTILIZAR STATEMENT SÓLO EN QUERIES NO PARAMETRIZADAS.


        ps = conexion.prepareStatement(sql);
        ps.setInt(1, numero);
        listado = ps.executeQuery();

        if (listado.next()) {
            int numSocio = listado.getInt("id");
            String tipoEntrenamiento = listado.getString("tipoEntrenamiento");
            String ubicacion = listado.getString("ubicacion");
            String fechaRealizacion = listado.getString("fechaRealizacion");

%>

<table>
    <tr>
        <td><%= numSocio%></td>
        <td><%= tipoEntrenamiento%></td>
        <td><%= ubicacion%></td>
        <td><%= fechaRealizacion%></td>
    </tr>
    <tr>
        <td>
            <form action="index.jsp">
                <input type="submit" value="Go to Index"/>
            </form>
        </td>
    </tr>
</table>
<%
        }
    }

    listado.close();
    ps.close();
    conexion.close();
%>




</body>
</html>
