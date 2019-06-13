<%-- 
    Document   : colegioEditar
    Created on : 12-jun-2019, 11:14:54
    Author     : danielfarias
--%>

<%@page import="dto.Colegio"%>
<%@page import="dao.DaoColegio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <title>Editar Colegio</title>
        <script type="text/javascript">
            function editarColegio() {
                var idColegio = $('#idColegio').val();
                var nombreParam = $('#nombre').val();
                var direccionParam = $('#direccion').val();
                var editarColegio = $('#accion').val();
                $.post('ServletColegio', {
                    idColegio: idColegio,
                    nombre: nombreParam,
                    direccion: direccionParam,
                    accion: editarColegio
                }, function () {
                    $('#mensajeColegio').css("display", "block");
                });
            }
        </script>
    </head>
    <body>
        <%
            String idColegio = request.getAttribute("idColegio").toString();
            DaoColegio daoColegio = new DaoColegio();
            Colegio colegio = daoColegio.buscar(Integer.parseInt(idColegio));

        %>

        <div class="container">
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">

                    
                    <a href="colegio.jsp" class="btn btn-success">Volver a Colegio</a>
                    <h1>Editar Colegio</h1>
                    <div class="form-group">
                        <label>Nombre</label>
                        <input type="text" name="nombre" id="nombre" class="form-control" placeholder="nombre colegio" value="<%=colegio.getNombreColegio()%>">
                        <label>Direccion</label>
                        <input type="text" name="direccion" id="direccion" class="form-control" placeholder="direccion colegio" value="<%=colegio.getDireccionColegio()%>">
                        <input type="hidden"  name="idColegio" id="idColegio" value="<%=colegio.getIdColegio()%>">
                    </div>
                    <button onclick="editarColegio()" type="button" class="btn btn-success" id="accion" value="actualizarColegio" name="accion">Editar</button>

                </div>

            </div>
            <div class="row">
                <div class="col-md-4 offset-4 col-md-4">
                    <div style="display:none" id="mensajeColegio" class="alert alert-success" role="alert">Colegio Editado</div>
                </div>
            </div>
        </div>
    </body>
</html>
