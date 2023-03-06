<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Comiclandia.aspx.vb" Inherits="AlgarTech.Comiclandia" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>ComicLandia</title>
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="css/Estilo_Modal_small.css" rel="stylesheet" />
    <link href="css/Estilo_modal_mensaje.css" rel="stylesheet" />
    <script type="text/javascript">
        function Cerrar_Boostrap() {
            //cierra el modal Bootstrap
            $('#currentdetail').modal('hide');
            $('.modal-backdrop').hide();
            //fin cierre modal Bootstrap 
        }

        function abrir_modal_Mensaje() {
            //document.getElementById("Modal_5").click();
            document.getElementById("popup_Mensaje").style.display = 'flex';
        }
        function OcultarModalMensaje() {
            document.getElementById("popup_Mensaje").style.display = 'none';
        }
        function abrir_modal_Small() {
            //document.getElementById("Modal_5").click();
            document.getElementById("popup_solicitud").style.display = 'flex';
        }
        function OcultarModalSmall() {
            document.getElementById("popup_solicitud").style.display = 'none';
        }

    </script>
    <style type="text/css">
        .auto-style1 {
            width: 32px;
            height: 32px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>ComicLandia</h1>
            <h2>Agregar Pedido</h2>
            <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="36000">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table width="100%" runat="server">
                        <tr>
                            <td class="etiqueta">
                                <asp:Label ID="lblNombreProducto" runat="server" Text="Nombre del producto:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNombreProducto" runat="server"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="etiqueta">
                                <asp:Label ID="Label1" runat="server" Text="Cantidad del Producto"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCantidadProducto" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="etiqueta">
                                <asp:Label ID="lblValorProducto" runat="server" Text="Valor U/n del Producto"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtValorUniProducto" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td id="filaBoton" class="FilaBoton" colspan="2">
                                <asp:Button ID="btnAgregar" runat="server" Text="Agregar Producto" CssClass="boton" />
                            </td>
                        </tr>
                        <tr id="FilaGridviewProductos">
                            <td colspan="2">
                                <asp:GridView ID="grvProductos" CssClass="grvPedidos" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Nombre Producto" DataField="nombre_producto" >
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Cantidad Producto" DataField="cantidad_producto" >
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Valor u/n Producto" DataField="valor_producto" >
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="total_productos" HeaderText="Total Producto" >
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                        <asp:ButtonField ButtonType="Image" CommandName="Modificar" ImageUrl="~/images/Editar2.png" HeaderText="Modificar">
                                            <ControlStyle Height="25px" Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="45px" />
                                        </asp:ButtonField>
                                        <asp:TemplateField HeaderText="Eliminar">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex ") %>' CommandName="Eliminar" Height="25px" ImageUrl="~/images/eliminar2.png" OnClientClick="return confirm('¿Esta seguro de eliminar este registro?');" Text="" Width="25px" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>

                        </tr>
                        <tr id="FilaTotalPedido">
                            <td colspan="2" align="center">
                                <asp:Label ID="lblTotalPedido" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="FilaBtnRealizarPedido">
                            <td colspan="2" class="FilaBoton">
                                <asp:Button ID="btnRealizarPedido" runat="server" Text="Realizar Pedido" CssClass="boton"/>
                            </td>
                        </tr>
                    </table>
                    <%--Inicio Modal Mensaje--%>
                    <div class="page_Mensaje" style="display: none">
                        <div class="page__container_Mensaje">
                            <a id="Modal_5" href="#popup_Mensaje" class="open-popup_Mensaje" visible="false">open</a>
                        </div>
                    </div>
                    <div id="popup_Mensaje" class="popup_Mensaje">
                        <div class="popup__block_Mensaje">
                            <%--<a href="#" class="popup__close_small">close</a>--%>
                            <asp:Label ID="lblCerrarModal" runat="server" class="popup__close_Mensaje" onclick="OcultarModalMensaje()"></asp:Label>
                            <div class="popup_contenido">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <div class="datagrid">
                                            <table runat="server" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th align="center" class="filaValidadion">
                                                                <asp:Label runat="server" id="lblTipoValidacion" CssClass="tipoValidacion">Confirmacion</asp:Label>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td align="center" class="filaMensaje">
                                                           <asp:Label ID="lblMensaje" runat="server" CssClass="Mensaje"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                         <td align="center" class="filaBtnValidacion">
                                                           <asp:Button runat="server" ID="Button1" Text="Aceptar" CssClass="boton botonValidacion"/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <%--Fin Modal Mensaje--%>
                      <%--Inicio Modal Confirmar Pedido--%>
                    <div class="page_small" style="display: none">
                        <div class="page__container_small">
                            <a id="Modal_6" href="#" class="open-popup_small" visible="false">open</a>
                        </div>
                    </div>
                    <div id="popup_solicitud" class="popup_Small">
                        <div class="popup__block_small">
                            <a href="#" class="popup__close_small" onclick="OcultarModalSmall()">close </a>
                            <%--<asp:Label ID="Label2" runat="server" class="popup__close_small" onclick="OcultarModalDefinicion()"></asp:Label>--%>
                            <div class="popup_contenido">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <div class="datagrid">
                                            <table runat="server" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th colspan="2" style="font-size: 1.6em; height: 20px; text-align: center">
                                                            <h2 align="center">Confirmar Pedido</h2>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <th colspan="2" style="font-size: 1em; height: 20px; text-align: center">
                                                            <h2 align="center">Informacion de Envio</h2>
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td class="texto_modal" style="padding-bottom: 10px">Nombre:</td>
                                                        <td class="controles_modal">
                                                            <asp:TextBox ID="txtNombrePedido" runat="server"></asp:TextBox>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="texto_modal" style="padding-bottom: 10px">Numero de Documento:</td>
                                                        <td class="controles_modal">
                                                            <asp:TextBox ID="txtNumeroDocumento" runat="server"></asp:TextBox>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="texto_modal">Direccion de envio:</td>
                                                        <td class="controles_modal">
                                                            <asp:TextBox ID="txtDireccion" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="FilaBotonAceptar">
                                                        <td class="FilaBoton" colspan="2" >
                                                            <asp:Button runat="server" ID="btnAceptar" Text="Aceptar" CssClass="boton botonConfirmacion"/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <%--Fin Modal Confirmar Pedido--%>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
