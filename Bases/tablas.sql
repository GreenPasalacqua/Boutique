CREATE TABLE ARTICULO
(
  id_articulo      SMALLSERIAL PRIMARY KEY NOT NULL,
  modelo           VARCHAR(10)             NOT NULL,
  precio_venta     NUMERIC(12, 2)          NOT NULL,
  precio_proveedor NUMERIC(12, 2)          NOT NULL,
  descripcion      VARCHAR(100)            NOT NULL,
  tipo_prenda      VARCHAR(15)             NOT NULL
);


CREATE TABLE CLIENTE
(
  id_cliente       SMALLSERIAL PRIMARY KEY NOT NULL,
  nombre           VARCHAR(20)             NOT NULL,
  apellido_paterno VARCHAR(20),
  apellido_materno VARCHAR(20),
  calle            VARCHAR(30),
  numero           VARCHAR(10),
  colonia          VARCHAR(20),
  cp               CHAR(5),
  telefono         CHAR(10)                NOT NULL,
  email            VARCHAR(40)
);

CREATE TABLE APARTADO
(
  num_apartado SMALLINT       NOT NULL,
  id_cliente   SMALLINT       NOT NULL REFERENCES CLIENTE (id_cliente),
  total        NUMERIC(12, 2) NOT NULL,
  fecha        DATE           NOT NULL,
  PRIMARY KEY (num_apartado, id_cliente)
);

CREATE TABLE ABONO
(
  num_abono    SMALLINT       NOT NULL,
  num_apartado SMALLINT       NOT NULL,
  id_cliente   SMALLINT       NOT NULL,
  total        NUMERIC(12, 2) NOT NULL,
  fecha        DATE           NOT NULL,
  PRIMARY KEY (num_abono, num_apartado, id_cliente),
  FOREIGN KEY (num_apartado, id_cliente) REFERENCES APARTADO (num_apartado, id_cliente)
);

CREATE TABLE VENTA
(
  id_venta   SMALLSERIAL PRIMARY KEY NOT NULL,
  fecha      DATE                    NOT NULL,
  monto      NUMERIC(12, 2)          NOT NULL,
  id_cliente SMALLINT                NOT NULL REFERENCES CLIENTE (id_cliente)
);


CREATE TABLE contiene_a
(
  id_articulo SMALLINT    NOT NULL REFERENCES ARTICULO (id_articulo),
  id_venta    SMALLINT    NOT NULL REFERENCES VENTA (id_venta),
  cantidad    SMALLINT    NOT NULL,
  color       VARCHAR(11) NOT NULL,
  talla       VARCHAR(8)  NOT NULL,
  PRIMARY KEY (id_articulo, id_venta, color, talla)
);

CREATE TABLE ESTILO
(
  id_estilo SMALLSERIAL PRIMARY KEY NOT NULL,
  talla     VARCHAR(11)             NOT NULL,
  color     VARCHAR(8)              NOT NULL
);

CREATE TABLE corresponde_a
(
  id_estilo   SMALLINT NOT NULL REFERENCES ESTILO (id_estilo),
  id_articulo SMALLINT NOT NULL REFERENCES ARTICULO (id_articulo),
  cantidad    SMALLINT NOT NULL,
  PRIMARY KEY (id_estilo, id_articulo)
);

CREATE TABLE PROVEEDOR
(
  id_proveedor SMALLSERIAL PRIMARY KEY NOT NULL,
  nombre       VARCHAR(20)             NOT NULL,
  telefono     CHAR(10)                NOT NULL,
  ciudad       VARCHAR(30)             NOT NULL,
  estado       VARCHAR(30)             NOT NULL,
  calle        VARCHAR(30)             NOT NULL,
  numero       VARCHAR(10)             NOT NULL,
  colonia      VARCHAR(20)             NOT NULL,
  cp           CHAR(5)                 NOT NULL
);

CREATE TABLE FACTURA
(
  id_factura   SMALLSERIAL PRIMARY KEY NOT NULL,
  fecha        DATE                    NOT NULL,
  monto        NUMERIC(12, 2)          NOT NULL,
  gasto_envio  NUMERIC(12, 2)          NOT NULL,
  id_proveedor SMALLINT                NOT NULL REFERENCES PROVEEDOR (id_proveedor)
);

CREATE TABLE incluido_en
(
  id_factura  SMALLINT    NOT NULL REFERENCES FACTURA (id_factura),
  id_articulo SMALLINT    NOT NULL REFERENCES ARTICULO (id_articulo),
  cantidad    SMALLINT    NOT NULL,
  color       VARCHAR(11) NOT NULL,
  talla       VARCHAR(8)  NOT NULL,
  CONSTRAINT incluido_en_id_factura_id_articulo_color_talla_pk
  PRIMARY KEY (id_factura, id_articulo, color, talla)
);

CREATE TABLE incluye_a
(
  id_articulo  SMALLINT    NOT NULL REFERENCES ARTICULO (id_articulo),
  num_apartado SMALLINT    NOT NULL,
  id_cliente   SMALLINT    NOT NULL,
  cantidad     SMALLINT    NOT NULL,
  color        VARCHAR(11) NOT NULL,
  talla        VARCHAR(8)  NOT NULL,
  PRIMARY KEY (id_articulo, num_apartado, id_cliente, color, talla),
  FOREIGN KEY (num_apartado, id_cliente) REFERENCES APARTADO (num_apartado, id_cliente)
);

CREATE TABLE NOTA
(
  id_nota  SMALLSERIAL PRIMARY KEY NOT NULL,
  id_venta SMALLINT                NOT NULL REFERENCES VENTA (id_venta)
);

CREATE TABLE ORDEN_PEDIDO
(
  id_orden     SMALLSERIAL PRIMARY KEY NOT NULL,
  fecha        DATE                    NOT NULL,
  monto        NUMERIC(12, 2)          NOT NULL,
  id_proveedor SMALLINT                NOT NULL REFERENCES PROVEEDOR (id_proveedor),
  id_factura   SMALLINT REFERENCES FACTURA (id_factura)
);

CREATE TABLE PREFERENCIA
(
  id_preferencia SMALLINT     NOT NULL,
  id_cliente     SMALLINT     NOT NULL REFERENCES CLIENTE (id_cliente),
  talla          VARCHAR(8)   NOT NULL,
  descripcion    VARCHAR(100) NOT NULL,
  tipo_prenda    VARCHAR(30)  NOT NULL,
  PRIMARY KEY (id_preferencia, id_cliente)
);

CREATE TABLE PROVEEDOR_DIRECTO
(
  id_proveedor SMALLINT PRIMARY KEY NOT NULL REFERENCES PROVEEDOR (id_proveedor)
);

CREATE TABLE PROVEEDOR_POR_PEDIDO
(
  id_proveedor SMALLINT PRIMARY KEY NOT NULL REFERENCES PROVEEDOR (id_proveedor),
  email        VARCHAR(40)          NOT NULL,
  pagina_web   VARCHAR(40)
);

CREATE TABLE se_devolvio
(
  id_articulo SMALLINT    NOT NULL REFERENCES ARTICULO (id_articulo),
  id_venta    SMALLINT    NOT NULL REFERENCES VENTA (id_venta),
  fecha       DATE        NOT NULL,
  cantidad    SMALLINT    NOT NULL,
  color       VARCHAR(11) NOT NULL,
  talla       VARCHAR(8)  NOT NULL,
  PRIMARY KEY (id_articulo, id_venta, fecha, color, talla)
);

CREATE TABLE se_pide_en
(
  id_orden    SMALLINT    NOT NULL REFERENCES ORDEN_PEDIDO (id_orden),
  id_articulo SMALLINT    NOT NULL REFERENCES ARTICULO (id_articulo),
  cantidad    SMALLINT    NOT NULL,
  color       VARCHAR(11) NOT NULL,
  talla       VARCHAR(8)  NOT NULL,
  PRIMARY KEY (id_orden, id_articulo, color, talla)
);

CREATE TABLE surtido_por
(
  id_proveedor SMALLINT    NOT NULL REFERENCES PROVEEDOR (id_proveedor),
  id_articulo  SMALLINT    NOT NULL REFERENCES ARTICULO (id_articulo),
  cantidad     SMALLINT    NOT NULL,
  fecha_envio  DATE        NOT NULL,
  talla        VARCHAR(8)  NOT NULL,
  color        VARCHAR(11) NOT NULL,
  PRIMARY KEY (id_proveedor, id_articulo, color, talla, fecha_envio)
);