<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Respuesta</title>
    </head>
    <body>
        <%
        try {
            Dba db = new Dba(application.getRealPath("ExamenPrimerParcial.mdb"));
            db.conectar();
            int contador=db.query.executeUpdate("UPDATE tareas_personas "
                + "SET duracion='"+request.getParameter("nuevo_valor") + "'"
                + "WHERE actividad='"+ request.getParameter("actividad")+"' ");
            if(contador>=1){ 
                out.print("<div id='respuesta'>Actividad" + request.getParameter("actividad") + " modificada satisfactoriamente</div>");             
            }
            db.commit();
            db.desconectar();
        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
            out.print("<div id='respuesta'> " + e + "</div>");
        }
%>
    </body>

</html>

