<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <h2>Introduzca los datos del nuevo socio:</h2>
    <form method="get" action="grabaPartido.jsp">
      id Partido <input type="text" name="id"/></br>
      fecha <input type="text" name="fecha"/></br>
      equipo1 <input type="text" name="equipo1"/></br>
      Puntos Equipo1 <input type="number" name="puntos_equipo1"/></br>
      equipo2 <input type="text" name="equipo2"/></br>
      Puntos Equipo2 <input type="number" name="puntos_equipo2"/></br>
      <select name="tipo_partido" id="tipo_partido" multiple>
        <option value="amistoso">amistoso</option>
        <option value="oficial">oficial</option>
      </select>
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