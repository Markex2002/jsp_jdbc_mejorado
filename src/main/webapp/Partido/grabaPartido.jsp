<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int id = -1;
    String fecha = null;
    String equipo1 = null;
    int puntos_equipo1 = -1;
    String equipo2 = null;
    int puntos_equipo2 = -1;
    String tipo_partido = null;

    //Flags
    boolean flagValidaId = false;
    boolean flagValidaFecha = false;
    boolean flagValidaEquipo1 = false;
    boolean flagValidaPuntosEquipo1 = false;
    boolean flagValidaEquipo2 = false;
    boolean flagValidaPuntosEquipo2 = false;
    boolean flagValidaTipoPartido = false;


    try {
        id = Integer.parseInt(request.getParameter("id"));
        flagValidaId = true;


        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("fecha").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        fecha = request.getParameter("fecha");
        flagValidaFecha = true;

        if (request.getParameter("equipo1").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        equipo1 = request.getParameter("equipo1");
        flagValidaEquipo1 = true;

        puntos_equipo1 = Integer.parseInt(request.getParameter("puntos_equipo1"));
        flagValidaPuntosEquipo1 = true;

        if (request.getParameter("equipo2").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        equipo2 = request.getParameter("equipo2");
        flagValidaEquipo2 = true;

        puntos_equipo2 = Integer.parseInt(request.getParameter("puntos_equipo2"));
        flagValidaPuntosEquipo2 = true;


        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("tipo_partido"));
        flagValidaTipoPartido = true;
        //CONTRACT nonBlank
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("tipo_partido").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        tipo_partido = request.getParameter("tipo_partido");
        flagValidaTipoPartido = true;

    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;

        if (!flagValidaId){
            session.setAttribute("error", "error ID");
        } else if (!flagValidaFecha){
            session.setAttribute("error", "error Fecha No valida");
        } else if (!flagValidaEquipo1){
            session.setAttribute("error", "error nombre Equipo1 no valido");
        } else if (!flagValidaPuntosEquipo1){
            session.setAttribute("error", "error, puntos no validos");
        }  else if (!flagValidaEquipo2){
            session.setAttribute("error", "error nombre Equipo1 no valido");
        } else if (!flagValidaPuntosEquipo2){
            session.setAttribute("error", "error, puntos no validos");
        } else if (!flagValidaTipoPartido){
            session.setAttribute("error", "error Tipo Partido");
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
            conn = DriverManager.getConnection("jdbc:mysql://localhost:30306/juego", "root", "user");


            String sql = "INSERT INTO partido VALUES ( " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?)";

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, id);
            ps.setString(idx++, fecha);
            ps.setString(idx++, equipo1);
            ps.setInt(idx++, puntos_equipo1);
            ps.setString(idx++, equipo2);
            ps.setInt(idx++, puntos_equipo2);
            ps.setString(idx++, tipo_partido);


            int filasAfectadas = ps.executeUpdate();
            System.out.println("PARTIDOS GRABADOS:  " + filasAfectadas);


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
        out.println("Partido dado de alta.");
        //Redireccionamos a Listado Partido

        response.sendRedirect("listadoPartidos.jsp");

} else {
        response.sendRedirect("formularioPartido.jsp");
        out.println("Error de validación!");
    }
%>

</body>
</html>
