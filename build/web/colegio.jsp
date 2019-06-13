<%-- 
    Document   : colegio
    Created on : 10-jun-2019, 20:18:01
    Author     : danielfarias
--%>

<%@page import="java.util.List"%>
<%@page import="dto.Colegio"%>
<%@page import="dao.DaoColegio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="http://code.jquery.com/jquery-latest.js"></script>

        <title>Colegio</title>

        <script type="text/javascript">
            function guardarColegio() {
                var nombreParam = $('#nombre').val();
                var direccionParam = $('#direccion').val();
                var guardarColegio = $('#accion').val();
                $.post('ServletColegio', {
                    nombre: nombreParam,
                    direccion: direccionParam,
                    accion: guardarColegio
                }, function (data) {
                    $('#mensajeColegioGuardado').css("display", "block");
                    $('#mensajeColegioEliminado').css("display", "none");
                    var nuevoContenido = crearListaActualizada(data);
                    $('#contenidoListaColegios').html("");
                    $('#contenidoListaColegios').html(nuevoContenido);
                }, "json");
            }
            function eliminarColegio(idColegio) {
                $.post('ServletColegio', {
                    idColegio: idColegio,
                    accion: 'eliminarColegio'
                }, function (data) {
                    $('#mensajeColegioGuardado').css("display", "none");
                    $('#mensajeColegioEliminado').css("display", "block");
                    var nuevoContenido = crearListaActualizada(data);
                    $('#contenidoListaColegios').html("");
                    $('#contenidoListaColegios').html(nuevoContenido);
                }, "json");

            }
            function crearListaActualizada(lista) {
                var html = '';
                var i = 0;
                $.each(lista, function (index, itemColegio) {
                    i++;
                    html += '<tr> ';

                    html += '                <td>' + i + '</td> ';
                    html += '                <td>' + itemColegio.nombreColegio + '</td> ';
                    html += '                 <td>' + itemColegio.direccionColegio + '</td> ';
                    html += '                <td><button class="btn btn-danger" onclick="eliminarColegio(' + itemColegio.idColegio + ')">Eliminar</button></td> ';
                    html += '             <td><a class="btn btn-warning" href="ServletColegio?accion=editarColegio&idColegio=' + itemColegio.idColegio + '">Editar</a></td> ';
                    html += '          </tr> ';
                });
                return html;
            }
        </script>
    </head>
    <body>
<a href="menu.jsp" class="alert alert-success" role="alert">Volver a menu</a>

        <div class="container">
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    
                    <h1>Colegio</h1>
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" placeholder="nombre colegio">
                        <label>Direccion</label>
                        <input type="text" name="direccion" id="direccion" class="form-control" placeholder="direccion colegio">
                    </div>
                    <button onclick="guardarColegio()" type="button" class="btn btn-success" id="accion" value="guardarColegio" name="accion">Guardar</button>

                </div>

            </div>
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <div style="display:none" id="mensajeColegioGuardado" class="alert alert-success" role="alert">Colegio Guardado</div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <div style="display:none" id="mensajeColegioEliminado" class="alert alert-success" role="alert">Colegio Eliminado</div>
                </div>
            </div>
        </div>

    <div class="row">
        <div class="col-md-8 offset-2 col-md-2">
            <div class="panel panel-default">
                <div class="panel-heading">Lista de Colegios</div>

                <table class="table table-fixed">
                    <thead> 
                        <tr> 
                            <th>#</th> 
                            <th>Nombre</th> 
                            <th>Descripcion</th> 
                            <th>Eliminar</th> 
                            <th>Editar</th> 
                        </tr> 
                    </thead>
                    <tbody id="contenidoListaColegios"> 
                        <%
                            DaoColegio daoColegio = new DaoColegio();
                            List<Colegio> colegios = daoColegio.listar();
                            int index = 0;
                            for (Colegio itemColegio : colegios) {
                                index++;

                        %>
                        <tr> 
                            <td><%=index%></td> 
                            <td><%=itemColegio.getNombreColegio()%></td> 
                            <td><%=itemColegio.getDireccionColegio()%></td> 
                            <td><button class="btn btn-danger" onclick="eliminarColegio(<%=itemColegio.getIdColegio()%>)">Eliminar</button></td> 
                            <td><a class="btn btn-warning"  href="ServletColegio?accion=editarColegio&idColegio=<%=itemColegio.getIdColegio()%>">Editar</a></td> 
                        </tr> 
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div> 
    </div>
</div>
</body>
</html>
