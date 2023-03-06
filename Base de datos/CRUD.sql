ALTER PROCEDURE [dbo].[uspInsertProcuto] (@vrcNombreProducto VARCHAR (100),@intCantidadProducto INT, @mnyValorProducto MONEY,@intIdPedido INT)
WITH  ENCRYPTION
AS
BEGIN

		DECLARE @intIdIngresadoPedido int

		INSERT INTO info_productos (nombre_producto,cantidad_producto,valor_producto,id_pedido) VALUES (@vrcNombreProducto,@intCantidadProducto,@mnyvalorProducto,@intIdPedido)

		SELECT * FROM info_productos where id_pedido = @intIdPedido
END

