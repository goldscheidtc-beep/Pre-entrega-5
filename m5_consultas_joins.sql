/*===================== Consultas con JOINs para el proyecto =====================*/

/*===========================================================
Consulta 1 — Vista base del proyecto (INNER JOIN)
Propósito: generar la vista principal con ventas, clientes y productos
===========================================================*/

SELECT 
    v.id_venta,
    v.fecha_venta,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.email,
    c.ciudad,
    v.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;

-- Hallazgo: La tabla muestra las ventas junto con datos de clientes y productos. Se puede ver qué productos se vendieron, a quién y en qué ciudad.

  /*===========================================================
Consulta 2 — Clientes sin ventas (LEFT JOIN) 
Propósito: detectar clientes registrados que nunca compraron
===========================================================*/

SELECT 
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Hallazgo: No apareció ningún cliente sin compras, es decir que la cantidad de registros es 0, todos los registrados ya realizaron al menos una venta. En este caso, para el area CRM, no tiene clientes pendientes de activar, porque todos ya realizaron al menos una compra.

/*===========================================================
Consulta 3 — Productos sin ventas (LEFT JOIN) 
Propósito: identificar productos del catálogo que no tuvieron ventas
===========================================================*/

SELECT 
    p.id_producto,
    p.nombre_producto,
    p.precio,
    p.stock
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- Hallazgo: Todos los productos del catálogo tuvieron al menos una venta, es decir la canridas de resgistros es 0. En este caso, para el área de Producto, esto significa que no hay artículos sin movimiento y que todos los productos se están vendiendo.

/*===========================================================
Consulta 4 — Consolidado por canal (UNION ALL)
Propósito: comparar las ventas entre dos categorías de productos
para identificar cuál genera más ingresos.
===========================================================*/


SELECT canal, SUM(total) AS total_canal
FROM (  
    -- Ventas Tecnología
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Tecnología' AS canal
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    WHERE p.id_categoria = 1

    UNION ALL

    -- Ventas Muebles
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Muebles' AS canal
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    WHERE p.id_categoria = 2
) AS consolidado
GROUP BY canal;

-- Hallazgo: La consulta muestra que Tecnología tuvo un total de 4950, indicando que tiene mas ventas. Mientras que Muebles alcanzó 744 implicando menos movimiento.


