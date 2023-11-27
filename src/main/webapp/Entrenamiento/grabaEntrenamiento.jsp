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
    int idEntrenamiento = -1;
    String tipoEntrenamiento = "";
    String ubicacion = "";
    String fechaRealizacion = "";

    //Flags
    boolean flagValidaId = false;
    boolean flagValidaEntrenamiento = false;
    boolean flagValidaUbicacion= false;
    boolean flagValidaFecha = false;

    try {
        idEntrenamiento = Integer.parseInt(request.getParameter("idEntrenamiento"));
        flagValidaId = true;

        tipoEntrenamiento = request.getParameter("tipo");
        if (tipoEntrenamiento.equals("fisico") || tipoEntrenamiento.equals("tecnico")){
            flagValidaEntrenamiento = true;
        } else {
            throw new RuntimeException();
        }

        ubicacion = request.getParameter("ubicacion");
        flagValidaUbicacion = true;

        fechaRealizacion = request.getParameter("fecha");
        flagValidaFecha = true;

    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;

        if (!flagValidaId){
            session.setAttribute("error", "error iD socio");
        } else if (!flagValidaEntrenamiento){
            session.setAttribute("error", "error tipo Entrenamiento");
        } else if (!flagValidaFecha){
            session.setAttribute("error", "error fecha Invalida");
        } else if (!flagValidaUbicacion){
            session.setAttribute("error", "error, Ubicacion no valida");
        }
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
// 	ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto", "root", "user");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO entrenamiento VALUES ( " +
                    "?, " + //IDEntrenamiento
                    "?, " + //tipo Entrenamiento
                    "?, " + //Ubicacion
                    "?)"; //Fecha

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, idEntrenamiento);
            ps.setString(idx++, tipoEntrenamiento);
            ps.setString(idx++, ubicacion);
            ps.setString(idx++, fechaRealizacion);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);


        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }
        out.println("Socio dado de alta.");
        //Redireccionamos a detalle socio, dando como parametro Numero
        //response.sendRedirect("detalleSocio.jsp?socioID="+numero);

        session.setAttribute("socioIDaDestacar", idEntrenamiento);
        response.sendRedirect("pideNumeroEntrenamiento.jsp");

    } else {
        response.sendRedirect("formularioEntrenamiento.jsp");
        out.println("Error de validación!");
    }
%>



</body>
</html>