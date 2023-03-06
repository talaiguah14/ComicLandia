IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[info_productos]') AND type in (N'U'))
BEGIN
CREATE TABLE info_productos
		(
		id_producto int NOT NULL IDENTITY (1, 1),
		nombre_producto varchar(100) NOT NULL,
		cantidad_producto int NOT NULL,
		valor_producto money NOT NULL,
		id_pedido int NOT NULL


		)  ON [PRIMARY]
	ALTER TABLE dbo.info_productos ADD CONSTRAINT
		PK_info_productos PRIMARY KEY CLUSTERED 
		(
		id_producto
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		ALTER TABLE [dbo].info_productos  WITH CHECK ADD  CONSTRAINT [FK_info_productos_info_pedidos] FOREIGN KEY(id_pedido)
		REFERENCES [dbo].[info_pedidos] ([id_pedido])
END

