Public Class Parametros
    Public Property Clave As String
    Public Property Valor As String

    Public Sub New()

    End Sub

    Public Sub New(_Clave As String, _Valor As String)
        Clave = _Clave
        Valor = _Valor
    End Sub
End Class
