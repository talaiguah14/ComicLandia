Imports RestSharp
Imports Newtonsoft.Json

Public Class DBapi
    Public Function postProductos(headers As List(Of Parametros), parametros As List(Of Parametros), objeto As Object) As String
        Dim Client = New RestClient()
        Dim response
        Dim url As String = "http://localhost:4000/api/producto/"
        Client.BaseUrl = New Uri(url)

        Dim request = New RestRequest()
        request.Method = Method.POST

        For Each item As Parametros In headers
            request.AddHeader(item.Clave, item.Valor)
        Next

        For Each parametro As Parametros In parametros
            request.AddParameter(parametro.Clave, parametro.Valor)
        Next

        If (parametros.Count = 0) Then
            request.AddJsonBody(objeto)
        End If

        response = Client.Execute(request).Content.ToString

        Return response
    End Function

    Public Function postPedidos(headers As List(Of Parametros), parametros As List(Of Parametros), objeto As Object) As String
        Dim Client = New RestClient()
        Dim url As String = "http://localhost:4000/api/pedidos/"
        Dim response
        Client.BaseUrl = New Uri(url)

        Dim request = New RestRequest()
        request.Method = Method.POST

        For Each item As Parametros In headers
            request.AddHeader(item.Clave, item.Valor)
        Next

        For Each parametro As Parametros In parametros
            request.AddParameter(parametro.Clave, parametro.Valor)
        Next

        If (parametros.Count = 0) Then
            request.AddJsonBody(objeto)
        End If

        response = Client.Execute(request).Content.ToString

        Return response
    End Function
End Class
