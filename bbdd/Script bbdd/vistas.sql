CREATE OR REPLACE VIEW INFORMACION_INVENTARIO AS
SELECT PR.IDPRODUCTO,PR.URLPORTADA,PR.NOMBRE, ES.DESCRIPCION as especie, PR.INFORMACIONADICIONAL, CAT.DESCRIPCION as categoria, PR.CANTIDAD, PR.PRECIO FROM PRODUCTO PR
INNER JOIN CATEGORIA CAT ON CAT.IDCATEGORIA=PR.CATEGORIA_IDCATEGORIA
INNER JOIN PRODUCTO_HAS_ESPECIE PRES ON PRES.PRODUCTO_IDPRODUCTO=PR.IDPRODUCTO
INNER JOIN ESPECIE ES ON ES.IDESPECIE=PRES.ESPECIE_IDESPECIE;

CREATE OR REPLACE VIEW CANTIDAD_INVENTARIO_POR_CATEGORIA AS
SELECT CAT.DESCRIPCION AS CATEGORIA, SUM(PR.CANTIDAD) AS CANTIDAD FROM PRODUCTO PR
INNER JOIN CATEGORIA CAT ON CAT.IDCATEGORIA=PR.CATEGORIA_IDCATEGORIA
WHERE PR.CANTIDAD>0
GROUP BY (CAT.DESCRIPCION);

CREATE OR REPLACE VIEW INFORMACION_USUARIO_PERFIL AS
select idusuario,imagenperfil,nombre,correo,
telefono,direccion from usuario;

CREATE OR REPLACE VIEW MODIFICAR_INVENTARIO AS
SELECT PR.IDPRODUCTO,PR.URLPORTADA,IP.URL as galeria,IP.IDIMAGENPRODUCTO AS idimagen ,PR.NOMBRE,TP.DESCRIPCION as TipoBase 
,ES.DESCRIPCION as especie, PR.INFORMACIONADICIONAL, CAT.DESCRIPCION as categoria, PR.CANTIDAD,
PR.PRECIO,PR.TAMANIO,PR.TIEMPOSOL,PR.FRECUENCIARIEGO FROM PRODUCTO PR
LEFT JOIN PRODUCTO_HAS_IMAGENPRODUCTO PRIM ON PRIM.PRODUCTO_IDPRODUCTO=PR.IDPRODUCTO
LEFT JOIN IMAGENPRODUCTO IP ON IP.IDIMAGENPRODUCTO=PRIM.IMAGENPRODUCTO_IDIMAGENPRODUCTO
INNER JOIN CATEGORIA CAT ON CAT.IDCATEGORIA=PR.CATEGORIA_IDCATEGORIA
INNER JOIN PRODUCTO_HAS_ESPECIE PRES ON PRES.PRODUCTO_IDPRODUCTO=PR.IDPRODUCTO
INNER JOIN ESPECIE ES ON ES.IDESPECIE=PRES.ESPECIE_IDESPECIE
INNER JOIN TIPOBASE TP ON TP.IDTIPOBASE = PR.TIPOBASE_IDTIPOBASE;

CREATE OR REPLACE VIEW INFORMACION_USUARIOS_REGISTRADOS AS
SELECT idusuario, nombre, correo, telefono, direccion, fecharegistro 
FROM USUARIO
WHERE tipo_usuario_idtipo_usuario = 2;

CREATE OR REPLACE VIEW INFORMACION_PROMOCIONES AS
SELECT A.promocion_idpromocion , B.idproducto , B.nombre , B.precio, C.porcentajedescuento, trunc((B.precio - (B.precio * C.porcentajedescuento)/100),2) AS precioConDescuento,C.fechafin
FROM promocion_has_producto AS A LEFT JOIN PRODUCTO AS B ON A.producto_idproducto = B.idproducto
LEFT JOIN promocion AS C ON A.promocion_idpromocion = C.idpromocion
ORDER BY A.promocion_idpromocion;
