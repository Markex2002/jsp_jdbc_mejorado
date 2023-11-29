<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<html>
<head>
    <title>BuscarSocio</title>
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int numero = -1;

    try {
        numero = Integer.parseInt(request.getParameter("socioID"));

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("socioID"));
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("socioID").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;
    }



    String sql = "SELECT * FROM socio WHERE socioID = ?";
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
            int numSocio = listado.getInt("socioID");
            String nombre = listado.getString("nombre");
            int estatura = listado.getInt("estatura");
            int edad = listado.getInt("edad");
            String localidad =  listado.getString("localidad");

%>

    <table>
        <tr>
            <td><%= numSocio%></td>
            <td><%= nombre%></td>
            <td><%= estatura%></td>
            <td><%= edad%></td>
            <td><%= localidad%></td>
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
