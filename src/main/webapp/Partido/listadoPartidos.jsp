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
      Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:30306/juego","root", "user");
      Statement s = conexion.createStatement();

      ResultSet listado = s.executeQuery ("SELECT * FROM partido");
    %>
    <table>
      <tr><th>ID</th><th>fecha</th><th>equipo1</th><th>PuntosEquipo1</th><th>Equipo2</th><th>PuntosEquipo2</th><th>Tipo Partido</th></tr>
    <%
      while (listado.next()) {
          %>
          <tr>
              <td><%=listado.getString("id")%></td>
              <td><%=listado.getString("fecha")%></td>
              <td><%=listado.getString("equipo1")%></td>
              <td><%=listado.getInt("puntos_equipo1")%></td>
              <td><%=listado.getString("equipo2")%></td>
              <td><%=listado.getInt("puntos_equipo2")%></td>
              <td><%=listado.getString("tipo_partido")%></td>

      <td>
          <form method="get" action="borraPartido.jsp">
            <input type="hidden" name="codigo" value="<%=listado.getString("id") %>"/>
            <input type="submit" value="borrar">
          </form>
          </td>
      <td>
          <form method="get" action="">
              <input type="hidden" name="codigo" value="<%=listado.getString("id") %>"/>
              <input type="submit" value="crear">
          </form>
      </td>
      <td>
      <form method="get" action="borraPartido.jsp">
          <input type="hidden" name="codigo" value="<%=listado.getString("id") %>"/>
          <input type="submit" value="modificar">
      </form>
    </td>
    </tr>
    <%
      } // while   
      conexion.close();
     %>
    </table>
  </body>
</html>