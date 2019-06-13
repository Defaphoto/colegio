<%-- 
    Document   : profesorEditar
    Created on : 12-jun-2019, 18:04:22
    Author     : danielfarias
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.Profesor"%>
<%@page import="dao.DaoProfesor"%>
<%@page import="dto.Asignatura"%>
<%@page import="dao.DaoAsignatura"%>
<%@page import="dto.Colegio"%>
<%@page import="dao.DaoColegio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/js/bootstrap-datetimepicker.min.js"></script>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">
        <title>Editar Profesor</title>
        <script>
            function editarProfesor(){
                var idColegio = $('#idColegio').val();
                var nombre = $('#nombre').val();
                var idAsignatura = $('#idAsignatura').val();
                var fechaNacimiento = $('#fechaNacimiento').val();
                var accion = $('#accion').val();
                var estado = $('#estado').val();
                var idProfesor = $('#idProfesor').val();
                $.post('ServletProfesor', {
                    idProfesor: idProfesor,
                    idColegio: idColegio,
                    nombre: nombre,
                    idAsignatura: idAsignatura,
                    accion: accion,
                    fechaNacimiento: fechaNacimiento,
                    estado: estado
                }, function () {
                    $('#mensajeProfesorEditado').css("display", "block");
                });
            }
            $(function () {
                $('#datetimepicker1').datetimepicker({format: 'DD/MM/YYYY'});
            });
            
        </script>
    </head>
    <body>
        <%
            String idProfesor = request.getAttribute("idProfesor").toString();
            DaoProfesor daoProfesor = new DaoProfesor();
            Profesor profesor = daoProfesor.buscar(Integer.parseInt(idProfesor));
            
            SimpleDateFormat parseador = new SimpleDateFormat("dd-MM-yy");
            SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yy");

            Date date = parseador.parse(profesor.getFechaNacProfesor().toString());
            
            
        %>
        <div class="container">
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <a href="profesor.jsp" class="btn btn-success">Volver a Profesor</a>
                    <h1>Editar Profesor</h1>
                    <div class="form-group">
                        <input  type="hidden" id="idProfesor" value="<%=profesor.getIdProfesor()  %>"/>
                        <label>Nombre</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" placeholder="nombre profesor" value="<%=profesor.getNombreProfesor()%>">
                        <label>Fecha nacimiento</label>
                        <div class='input-group date' id='datetimepicker1'>
                            <input type='text' class="form-control" id="fechaNacimiento" value="<%=formateador.format(date) %>"/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        <label>Colegio</label>
                        <select class="form-control" id="idColegio">

                            <%
                                DaoColegio daoColegio = new DaoColegio();
                                for (Colegio itemColegio : daoColegio.listar()) {
                                    if (itemColegio.getIdColegio() == profesor.getColegio().getIdColegio()) {
                            %>
                            <option value="<%=itemColegio.getIdColegio()%>" selected=""><%=itemColegio.getNombreColegio()%></option>

                            <%} else {%>

                            <option value="<%=itemColegio.getIdColegio()%>"><%=itemColegio.getNombreColegio()%></option>

                            <%}
                                }%>
                        </select>
                        <label>Asignatura</label>
                        <select class="form-control" id="idAsignatura">

                            <%
                                DaoAsignatura daoAsignatura = new DaoAsignatura();
                                for (Asignatura itemAsignatura : daoAsignatura.listar()) {
                                    if (itemAsignatura.getIdAsignatura() == profesor.getAsignatura().getIdAsignatura()) {
                            %>
                            <option value="<%=itemAsignatura.getIdAsignatura()%>" selected=""><%=itemAsignatura.getNombreAsignatura()%></option>
                            <%} else {%>
                            <option value="<%=itemAsignatura.getIdAsignatura()%>"><%=itemAsignatura.getNombreAsignatura()%></option>
                            <%}
                                }%>
                        </select>
                        <label>Estado</label>
                        <select class="form-control" id="estado">
                            <%
                                if (profesor.getEstadoProfesor().equals("Activo")) {
                            %>
                            <option value="Activo" selected>Activo</option>
                            <option value="Inactivo">Inactivo</option>
                            <%} else {%>
                            <option value="Activo">Activo</option>
                            <option value="Inactivo" selected>Inactivo</option>
                            <%}%>

                        </select>

                    </div>
                    <button onclick="editarProfesor()" type="button" class="btn btn-success" id="accion" value="actualizarProfesor" name="accion">Editar</button>

                </div>

            </div>
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <div style="display:none" id="mensajeProfesorEditado" class="alert alert-success" role="alert">Profesor Editado</div>
                </div>
            </div>
        </div>
    </body>
</html>
