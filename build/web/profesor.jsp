<%@page import="com.sun.org.apache.bcel.internal.generic.AALOAD"%>
<%@page import="dto.Profesor"%>
<%@page import="dao.DaoProfesor"%>
<%@page import="java.util.List"%>
<%@page import="dto.Asignatura"%>
<%@page import="dao.DaoAsignatura"%>
<%@page import="dto.Colegio"%>
<%@page import="dao.DaoColegio"%>
<%-- 
    Document   : profesor
    Created on : 12-jun-2019, 14:32:28
    Author     : danielfarias
--%>

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
        <script type="text/javascript">

            function guardarProfesor() {
                var idColegio = $('#idColegio').val();
                var nombre = $('#nombre').val();
                var idAsignatura = $('#idAsignatura').val();
                var fechaNacimiento = $('#fechaNacimiento').val();
                var accion = $('#accion').val();
                var estado = $('#estado').val();
                $.post('ServletProfesor', {
                    idColegio: idColegio,
                    nombre: nombre,
                    idAsignatura: idAsignatura,
                    accion: accion,
                    fechaNacimiento: fechaNacimiento,
                    estado: estado
                }, function (data) {
                    $('#mensajeProfesorGuardado').css("display", "block");
                    $('#mensajeProfesorEliminado').css("display", "none");
                    var nuevoContenido = crearListaActualizada(data);
                    $('#contenidoListaProfesores').html("");
                    $('#contenidoListaProfesores').html(nuevoContenido);
                });
            }
            function eliminarProfesor(idProfesor){
                $.post('ServletProfesor', {
                    idProfesor: idProfesor,
                    accion: 'eliminarProfesor'
                }, function (data) {
                    $('#mensajeProfesorGuardado').css("display", "none");
                    $('#mensajeProfesorEliminado').css("display", "block");
                    var nuevoContenido = crearListaActualizada(data);
                    $('#contenidoListaProfesores').html("");
                    $('#contenidoListaProfesores').html(nuevoContenido);
                });
            }
            function crearListaActualizada(lista){
                var html = '';
                var i = 0;
                $.each(lista, function (index, itemProfesor) {
                    i++;
                    html += '<tr> ';

                    html += '                <td>' + i + '</td> ';
                    html += '                <td>' + itemProfesor.nombreProfesor + '</td> ';
                    html += '                 <td>' + itemProfesor.fechaNacProfesor + '</td> ';
                    html += '                 <td>' + itemProfesor.colegio + '</td> ';
                    html += '                 <td>' + itemProfesor.asignatura + '</td> ';
                    html += '                 <td>' + itemProfesor.estadoProfesor + '</td> ';
                    
                    html += '                <td><button class="btn btn-danger" onclick="eliminarProfesor(' + itemProfesor.idProfesor + ')">Eliminar</button></td> ';
                    html += '             <td><a class="btn btn-warning" href="ServletProfesor?accion=editarProfesor&idProfesor=' + itemProfesor.idProfesor + '">Editar</a></td> ';
                    html += '          </tr> ';
                });
                return html;
            }
            $(function () {
                $('#datetimepicker1').datetimepicker({format: 'DD/MM/YYYY'});
            });
        </script>     
        <title>Profesor</title>
    </head>
    <body>

<a href="menu.jsp" class="alert alert-success" role="alert">Volver a menu</a>
        <div class="container">
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <h1>Profesor</h1>
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" placeholder="nombre profesor">
                        <label>Fecha nacimiento</label>
                        <div class='input-group date' id='datetimepicker1'>
                            <input type='text' class="form-control" id="fechaNacimiento" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                        <label>Colegio</label>
                        <select class="form-control" id="idColegio">

                            <%
                                DaoColegio daoColegio = new DaoColegio();
                                for (Colegio itemColegio : daoColegio.listar()) {

                            %>
                            <option value="<%=itemColegio.getIdColegio()%>"><%=itemColegio.getNombreColegio()%></option>
                            <%}%>
                        </select>
                        <label>Asignatura</label>
                        <select class="form-control" id="idAsignatura">

                            <%
                                DaoAsignatura daoAsignatura = new DaoAsignatura();
                                for (Asignatura itemAsignatura : daoAsignatura.listar()) {

                            %>
                            <option value="<%=itemAsignatura.getIdAsignatura()%>"><%=itemAsignatura.getNombreAsignatura()%></option>
                            <%}%>
                        </select>
                        <label>Estado</label>
                        <select class="form-control" id="estado">
                            <option value="Activo">Activo</option>
                            <option value="Inactivo">Inactivo</option>
                        </select>

                    </div>
                    <button onclick="guardarProfesor()" type="button" class="btn btn-success" id="accion" value="guardarProfesor" name="accion">Guardar</button>

                </div>

            </div>
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <div style="display:none" id="mensajeProfesorGuardado" class="alert alert-success" role="alert">Profesor Guardado</div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <div style="display:none" id="mensajeProfesorEliminado" class="alert alert-success" role="alert">Profesor Eliminado</div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 offset-2 col-md-2">
                <div class="panel panel-default">
                    <div class="panel-heading">Lista de Profesores</div>

                    <table class="table table-fixed">
                        <thead> 
                            <tr> 
                                <th>#</th> 
                                <th>Nombre</th> 
                                <th>Fecha Nacimiento</th> 
                                <th>Colegio</th> 
                                <th>Asignatura</th> 
                                <th>Estado</th> 
                                <th>Eliminar</th> 
                                <th>Editar</th> 
                            </tr> 
                        </thead>
                        <tbody id="contenidoListaProfesores"> 
                            <%
                                DaoProfesor daoProfesor = new DaoProfesor();

                                List<Profesor> profesores = daoProfesor.listar();
                                int index = 0;
                                for (Profesor itemProfesor : profesores) {
                                    index++;
                                    Colegio colegioBuscado = daoColegio.buscar(itemProfesor.getColegio().getIdColegio());
                                    Asignatura asignaturaBuscada = daoAsignatura.buscar(itemProfesor.getAsignatura().getIdAsignatura());
                            %>
                            <tr> 
                                <td><%=index%></td> 
                                <td><%=itemProfesor.getNombreProfesor()%></td> 
                                <td><%=itemProfesor.getFechaNacProfesor()%></td> 
                                <td><%=colegioBuscado.getNombreColegio()%></td> 
                                <td><%=asignaturaBuscada.getNombreAsignatura()%></td> 
                                <td><%=itemProfesor.getEstadoProfesor()%></td> 
                                <td><button class="btn btn-danger" onclick="eliminarProfesor(<%=itemProfesor.getIdProfesor()%>)">Eliminar</button></td> 
                                <td><a class="btn btn-warning"  href="ServletProfesor?accion=editarProfesor&idProfesor=<%=itemProfesor.getIdProfesor()%>">Editar</a></td> 
                            </tr> 
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div> 
        </div>
    </body>
</html>
