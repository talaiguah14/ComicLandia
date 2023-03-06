Imports UtilLibrary.WebUtil
Imports System.IO
Imports System.Data.OleDb
Imports Microsoft.VisualBasic
Imports Newtonsoft.Json
Imports System.Collections

Public Class Comiclandia
    Inherits System.Web.UI.Page

    Private Property DataTableAgregarProductos() As DataTable
        Get
            Return DirectCast(Session("DataTableAgregarProductos"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            Session("DataTableAgregarProductos") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not IsPostBack Then
                DeleteSession()
                limpiarCampos()
            End If
        Catch ex As Exception
            MsgBox("Ha ocurrido un error", Me.Page)
        End Try
    End Sub

    Shared Sub MsgBox(ByVal mensaje As String, ByVal pagina As System.Web.UI.Page)
        Dim scriptStr As String = "alert('" & mensaje & "');"
        ScriptManager.RegisterStartupScript(pagina, pagina.GetType, "msgBox", scriptStr, True)
    End Sub

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Dim strNombreProducto As String = String.Empty
        Dim intCantidadProducto As Integer = 0
        Dim dbDValorUnidad As Double = 0.0
        If String.IsNullOrEmpty(txtNombreProducto.Text) Then
            MsgBox("El Nombre del producto es obligatorio", Me.Page)
            Exit Sub
        End If
        If String.IsNullOrEmpty(txtCantidadProducto.Text) Then
            MsgBox("la cantidad del producto es obligatorio", Me.Page)
            Exit Sub
        End If
        If String.IsNullOrEmpty(txtValorUniProducto.Text) Then
            MsgBox("El valor unitario del producto es obligatorio", Me.Page)
            Exit Sub
        End If

        strNombreProducto = txtNombreProducto.Text
        intCantidadProducto = txtCantidadProducto.Text
        dbDValorUnidad = txtValorUniProducto.Text

        agregarProductoGrid(strNombreProducto, intCantidadProducto, dbDValorUnidad)

        limpiarCampos()

    End Sub

    Private Sub agregarProductoGrid(ByVal strNombreProducto As String, ByVal intCantidadProducto As Integer, ByVal dbValorProducto As Double)
        Dim rowProductos As DataRow = Nothing
        Dim dbTotalProductos As Double = Convert.ToDouble(intCantidadProducto) * Convert.ToDouble(dbValorProducto)


        InitDataTableAgregarProductos()

        rowProductos = DataTableAgregarProductos.NewRow

        rowProductos("nombre_producto") = strNombreProducto
        rowProductos("cantidad_producto") = Convert.ToInt32(intCantidadProducto)
        rowProductos("valor_producto") = Convert.ToDouble(dbValorProducto)
        rowProductos("total_productos") = dbTotalProductos

        DataTableAgregarProductos.Rows.Add(rowProductos)
        FillGridView(grvProductos, DataTableAgregarProductos)

        SumarTotales()

    End Sub

    Private Sub InitDataTableAgregarProductos()
        If (Session("DataTableAgregarProductos")) Is Nothing Then
            Dim listColumnas As New System.Collections.Generic.List(Of String)
            With listColumnas
                .Add("nombre_producto")
                .Add("cantidad_producto")
                .Add("valor_producto")
                .Add("total_productos")
            End With
            'End If

            DataTableAgregarProductos = UtilLibrary.DataSpecification.InitDataTable("DataTableAgregarProductos", listColumnas.ToArray())
        End If
        DataTableAgregarProductos = CType(Session("DataTableAgregarProductos"), DataTable)
    End Sub


    Private Sub DeleteSession()
        Session.Remove("DataTableAgregarProductos")
    End Sub

    Private Sub limpiarCampos()
        txtCantidadProducto.Text = String.Empty
        txtNombreProducto.Text = String.Empty
        txtValorUniProducto.Text = String.Empty
        txtDireccion.Text = String.Empty
        txtNombrePedido.Text = String.Empty
        txtNumeroDocumento.Text = String.Empty
    End Sub

    Public Sub SumarTotales()
        Dim intTotalFilas As Integer = grvProductos.Rows().Count
        Dim dbValorProducto As Double
        Dim TotalProducto As Double = 0
        If intTotalFilas > 0 Then
            For i As Integer = 0 To intTotalFilas - 1
                dbValorProducto = Convert.ToDouble(grvProductos.Rows(i).Cells(3).Text)
                TotalProducto = TotalProducto + dbValorProducto
            Next
            lblTotalPedido.Text = "El valor total del pedido es de: " + Convert.ToString(TotalProducto)
        End If
    End Sub

    Protected Sub btnRealizarPedido_Click(sender As Object, e As EventArgs) Handles btnRealizarPedido.Click
        Dim script As String
        If grvProductos.Rows().Count > 0 Then
            script = "abrir_modal_Small();"
            ScriptManager.RegisterStartupScript(Me, GetType(Page), "abrir_modal_Small", script, True)
        Else
            script = "abrir_modal_Mensaje();"
            ScriptManager.RegisterStartupScript(Me, GetType(Page), "abrir_modal_Mensaje", script, True)
            lblTipoValidacion.Text = "Validación"
            lblMensaje.Text = "Debe agregar producto ingresado,para poder continuar"
        End If
    End Sub

    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        Dim idPedido As Integer
        Dim status As Integer
        Dim script As String

        Dim headers = New List(Of Parametros) From {
           }

        Dim parametros = New List(Of Parametros)
        If grvProductos.Rows.Count > 0 Then

            idPedido = InsertarPedido(headers, parametros)

            status = IngresarProducto(headers, parametros, idPedido)

            If Not String.IsNullOrEmpty(status.ToString) Then
                script = "abrir_modal_Mensaje();"
                ScriptManager.RegisterStartupScript(Me, GetType(Page), "abrir_modal_Mensaje", script, True)
                lblMensaje.Text = "El pedido se ha realizado correctamente,Gracias por su compra"
                limpiarCampos()
            End If
        End If
    End Sub

    Private Function InsertarPedido(headers As List(Of Parametros), parametros As List(Of Parametros))
        Dim api = New DBapi()
        Dim pedido = New Pedido()
        Dim response = Nothing
        Dim idPedido As Integer
        Dim result = Nothing
        If String.IsNullOrEmpty(txtNumeroDocumento.Text) Then
            MsgBox("El Numero De Documento es obligatorio", Me.Page)
        End If

        If String.IsNullOrEmpty(txtNumeroDocumento.Text) Then
            MsgBox("La Direccion es obligatoria", Me.Page)
        End If

        pedido.nombrePedido = txtNombrePedido.Text
        pedido.cedulaPedido = txtNumeroDocumento.Text
        pedido.dereccionPedido = txtDireccion.Text

        response = api.postPedidos(headers, parametros, pedido)

        result = JsonConvert.DeserializeObject(Of Respuesta)(response)
        idPedido = result.idPedido.ToString()
        Return idPedido
    End Function

    Private Function IngresarProducto(headers As List(Of Parametros), parametros As List(Of Parametros), idPedido As Integer)
        Dim api = New DBapi()
        Dim producto = New Producto()
        Dim response = Nothing
        Dim result = Nothing
        Dim strNombreProducto As String
        Dim intcantidadProducto As Integer
        Dim dbValorProducto As Double
        producto.idPedido = idPedido
        If producto.idPedido <> 0 Then
            For i As Integer = 0 To grvProductos.Rows.Count - 1
                strNombreProducto = grvProductos.Rows(i).Cells(0).Text.ToString
                intcantidadProducto = Convert.ToInt32(grvProductos.Rows(i).Cells(1).Text.ToString)
                dbValorProducto = Convert.ToDouble(grvProductos.Rows(i).Cells(2).Text.ToString)

                producto.nombreProducto = strNombreProducto
                producto.cantidadProducto = intcantidadProducto
                producto.valorProducto = dbValorProducto

                response = api.postProductos(headers, parametros, producto)
            Next
        End If
        result = JsonConvert.DeserializeObject(Of Respuesta)(response)
        Return result.status.ToString
    End Function

    Protected Sub grvProductos_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvProductos.RowCommand
        Dim Rowindex As Integer = e.CommandArgument
        If e.CommandName = "Eliminar" Then
            DataTableAgregarProductos.Rows(Rowindex).Delete()
            grvProductos.DataSource = DataTableAgregarProductos
            grvProductos.DataBind()
            SumarTotales()
        End If
        If e.CommandName = "Modificar" Then
            txtNombreProducto.Text = DataTableAgregarProductos.Rows(Rowindex)("nombre_producto").ToString
            txtCantidadProducto.Text = DataTableAgregarProductos.Rows(Rowindex)("cantidad_producto").ToString
            txtValorUniProducto.Text = DataTableAgregarProductos.Rows(Rowindex)("valor_producto").ToString
            DataTableAgregarProductos.Rows(Rowindex).Delete()
            btnAgregar.Text = "Modificar Producto"
        End If
    End Sub
End Class