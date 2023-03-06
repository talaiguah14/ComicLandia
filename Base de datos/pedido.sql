IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[info_pedidos]') AND type in (N'U'))
BEGIN
CREATE TABLE info_pedidos
		(
		id_pedido int NOT NULL IDENTITY (1, 1),
		nombre_pedido varchar(100) NOT NULL,
		cedula_pedido varchar(50) NOT NULL,
		direccion_pedido varchar(50) NOT NULL,

		)  ON [PRIMARY]
	ALTER TABLE dbo.info_pedidos ADD CONSTRAINT
		PK_info_pedidos PRIMARY KEY CLUSTERED 
		(
		id_pedido
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

