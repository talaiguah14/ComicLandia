ALTER PROCEDURE [dbo].[uspInsertPedido] (@vrcNombrePedido VARCHAR (100),@vrcNumeroDocumento VARCHAR (50),@vrcDireccion VARCHAR (50))
WITH  ENCRYPTION
AS
BEGIN
		DECLARE @intIdIngresadoPedido int
		
		INSERT INTO info_pedidos (nombre_pedido,cedula_pedido,direccion_pedido) VALUES	(@vrcNombrePedido,@vrcNumeroDocumento,@vrcDireccion)

		SELECT @intIdIngresadoPedido = ISNULL(@@IDENTITY,0) 
	
		SELECT ISNULL(id_pedido,0) AS id_pedido FROM info_pedidos WHERE id_pedido = @intIdIngresadoPedido
END

