<%@page import="database.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">

<!--<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>-->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<style type="text/css">

    .page-header{
        margin-top: 30px;
    }

    .form1{
        margin-top: 30px;
    }
</style>

<html>
    <head>
        <title>Exmen 1</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>

        <div class="modal fade collapse" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nueva duracion</h5>
                        <button type="button" class="close btn-cerrar" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="recipient-name" class="form-control-label">Valor</label>
                                <input type="number" class="form-control" id="nuevo_valor" name="nuevo_valor">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-cerrar" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-modificar">Actualizar</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="container">
            <div class="page-header">
                <h1>Informe: <small>Filtrar por actividad de las personas</small></h1>
            </div>


            <div class="row"   style="border: darkgray; border-style: solid; border-radius: 15px; height: 130px;">
                <!--<input type="text" id="actividad_seleccionada" name="actividad_seleccionada" value="" />-->
                <form id="form_generar_reporte" class="form-horizontal"  style="margin:34px auto" action="index.jsp">
                    <label class="mr-sm-2" for="inlineFormCustomSelectPref">Tipo de Actividad</label>
                    <select name="actividad" class="custom-select mb-2 mr-sm-2 mb-sm-0" id="actividad">
                        <option selected="selected" value="<%=request.getParameter("actividad")%>"><%=request.getParameter("actividad")%></option> 
                        <%
                            try {
                                Dba db = new Dba(application.getRealPath("ExamenPrimerParcial.mdb"));
                                db.conectar();
                                db.query.execute("select DISTINCT actividad from tareas_personas");
                                ResultSet rs = db.query.getResultSet();
                                while (rs.next()) {
                        %>                       
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option> 
                        <%
                                }
                                db.desconectar();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %> 
                    </select>

                    <button name="btn-generar" type="submit"  class="btn btn-primary btn-generar">Generar Reporte</button>

                </form>

            </div>

            <table class="table">
                <thead class="thead-inverse">
                    <tr>
                        <th>Clase Soc</th>
                        <th>Nombre</th>
                        <th>Actividad</th>
                        <th>Duracion</th>
                        <th>Operacion</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Dba db = new Dba(application.getRealPath("ExamenPrimerParcial.mdb"));
                            db.conectar();
                            db.query.execute("select * from tareas_personas INNER JOIN Gente ON Gente.id = tareas_personas.id_persona where actividad = '" + request.getParameter("actividad") + "'");
//                            db.query.execute("select * from tareas_personas where actividad = 'Bailar' "); 
                            ResultSet rs = db.query.getResultSet();
                            while (rs.next()) {%>
                    <tr> 
                        <td><%=rs.getString(2)%></td> 
                        <td><%=rs.getString(5)%> <%=rs.getString(6)%></td>
                        <td><%=rs.getString(3)%></td > 
                        <td><%=rs.getString(4)%></td >
                        <!--<td><a href="modificar.jsp?p_idact=<%=request.getParameter("tipoActividad")%>">Modificar Actividad</a></td>-->
                        <td><a href="#" class="modificar">Modificar Actividad</a></td>
                    </tr>         
                    <%
                            }
                            db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>  
                </tbody>
            </table>
            <div>

                ACTIVIDAD SELECCIONADA:  <%=request.getParameter("actividad")%>             
            </div>

            <script>

                $('#exampleModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget) // Button that triggered the modal
                    var recipient = button.data('whatever') // Extract info from data-* attributes
                    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                    var modal = $(this)
                    modal.find('.modal-title').text('New message to ' + recipient)
                    modal.find('.modal-body input').val(recipient)
                })

                $(".btn-generar").click(function () {
//                    $("#actividad_seleccionada").text($("#actividad").val());
                });

                $(".modificar").click(function () {
                    $("#modal").collapse("show");
                });

                $(".btn-cerrar").click(function () {
                    $("#modal").collapse("hide");
                });

                $(".btn-modificar").click(function () {
                    $("#modal").collapse("hide");

                    // Stop form from submitting normally
                    event.preventDefault();
                    $.post("http://localhost:9999/EXAMEN1_10821092/modificar.jsp", {nuevo_valor: $("#nuevo_valor").val(), actividad: $("#actividad").val()})
                            .done(function (data) {
//                                alert(data);
                                console.log(data);
                            });
                    location.reload();
                });
                var actividad = "";

            </script>
    </body>
</html>
