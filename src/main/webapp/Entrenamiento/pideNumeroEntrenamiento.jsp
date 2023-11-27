<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" type="text/css" href="estilos.css" />
  </head>
  <body>
    <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto","root", "user");
      Statement s = conexion.createStatement();

      ResultSet listado = s.executeQuery ("SELECT * FROM entrenamiento");
    %>
    <table>
      <tr><th>id</th><th>tipoEntrenamiento</th><th>ubicación</th><th>fechaRealizacion</th></tr>
    <%
        Integer socioIdaDestacar = (Integer)session.getAttribute("socioIDaDestacar");
        String claseDestacar = " ";
      while (listado.next()) {

          %>
          <tr class=<%=claseDestacar%>>
              <td><%=listado.getInt("id")%></td>
              <td><%=listado.getString("tipoEntrenamiento")%></td>
              <td><%=listado.getString("ubicacion")%></td>
              <td><%=listado.getString("fechaRealizacion")%></td>

      <td>
      <form method="get" action="borraSocio.jsp">
        <input type="hidden" name="codigo" value="<%=listado.getString("id") %>"/>
        <input type="submit" value="borrar">
      </form>
      </td></tr>
    <%
      } // while   
      conexion.close();
     %>
    </table>
  </body>
</html>