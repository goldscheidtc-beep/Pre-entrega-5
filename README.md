# Consultas con JOINs para el proyecto 

### Consulta 1 — Vista base
- Une ventas con clientes y productos.
- Permite ver qué se vendió, a quién y en qué ciudad.

### Consulta 2 — Clientes sin ventas
- Busca clientes registrados que nunca compraron.
- Resultado: 0 clientes sin compras.
- Significa que todos los clientes ya hicieron al menos una compra.

### Consulta 3 — Productos sin ventas
- Busca productos del catálogo que nunca se vendieron.
- Resultado: 0 productos sin ventas.
- Significa que todo lo que está en el catálogo tuvo movimiento.

### Consulta 4 — Ventas por canal
- Compara ventas de Tecnología y Muebles.
- Resultado: Tecnología = 4950, Muebles = 744.
- Tecnología vende más, Muebles tiene menos movimiento.  
