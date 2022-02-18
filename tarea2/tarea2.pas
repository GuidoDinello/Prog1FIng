{

 Este es el archivo tarea2.pas que es el único que se entrega.
 Solo se deben implementar los subprogramas pedidos y, tal vez, otros
 auxiliares para ellos.

 NO se debe implementar aquí un progrma independiente.
 Este archivo se integra con principal2.pas, que lo incluye.

 Se compila mediante:
$ fpc -Co -Cr -Miso -gl principal2.pas

 y se ejecutan los casos de prueba mediante
$ ./principal2 < entradas/caso.txt

o
$ ./principal2 < entradas/caso.txt > mios/caso,txt
$ diff salidas/caso.txt mios/caso,txt

o de manera interactiva
$ ./principal2
y siguiendo el instructivo publicado.

}

function sonCartasIguales (a, b : TCarta) : boolean;
begin
  if a.comodin and b.comodin then {ambos comodines}
    sonCartasIguales := TRUE
  else
    if (not a.comodin) and (not b.comodin) then {ambos no comodines}
        sonCartasIguales := (a.numero = b.numero) and (a.palo = b.palo) {si tienen las mismas propiedades true sino false}
    else sonCartasIguales := false {si alguna es comodin y la otra no}
end;



procedure armarTablero (mazo: TMazo; cantCols: TRangoCols; var t: TTablero);
var
  pos: 1..N;
  fil: 1..(FILAS+1); {el +1 surge del caso borde donde se pida solo una columna con 8 cartas, la variable fil finalizaria con un valor de 9, pero esto no es problema porque nunca se accederia a tal fila pues inmediatamente despues de sumar uno a fil viene el chequeo}
  col: 1..COLS;

begin
  pos := 1;
  fil := 1;
  if mazo.tope >= cantCols then {controla el caso donde la cantidad de cartas del mazo sea menor a la cantidad de columnas querida, ejemplo linea 5 archivo 16}
    t.tope := cantCols
  else
    t.tope := mazo.tope;
  if t.tope > 0 then {si un tablero tiene 0 columnas no hay nada que armar}
    begin
    while (pos <= mazo.tope) do {mientras haya cartas en el mazo}
      begin
        for col := 1 to t.tope do {se itera en las columnas del tablero}
          if pos <= mazo.tope then {este chequeo adicional es necesario para tableros no cuadrados}
            begin
              t.columnas[col].cartas[fil] := mazo.cartas[pos]; {se asigna la carta del mazo a la posicion correspondiente en el tablero}
              t.columnas[col].tope := fil; {se actualiza la cantidad de filas de la j-esima columna}
              pos := pos + 1 {se avanza en el mazo}
            end;
        fil := fil + 1 {se itera en las filas del tablero}
      end
    end
end;


procedure levantarTablero (t: TTablero; var mazo: TMazo);
var
  col : 1..COLS;
  fil : 1..FILAS;
  pos : 1..N;
begin
  pos := 1;
  for col := 1 to t.tope do
    for fil := 1 to t.columnas[col].tope do {se itera en cada fila hasta la cantidad de filas de la columna correspondiente}
      begin
        mazo.cartas[pos] := t.columnas[col].cartas[fil]; {se escribe el valor del tablero en el mazo}
        pos := pos + 1 {se avanza en el mazo}
      end;
  mazo.tope := pos - 1 {se le resta uno para corregir el +1 de la instruccion anterior luego de cargar la ultima carta}
end;

function enQueColumna (carta : TCarta; t: TTablero): TRangoCols;
var
  fil : 1..FILAS;
  col : 0..COLS;
begin
  col := 0;
  repeat
      fil := 1; {se actualiza fila a 1 para que empiece a buscar en la fila 1 cuando pase a la siguiente columna}
      col := col + 1; {se avanza en las columnas}
      while (sonCartasIguales(t.columnas[col].cartas[fil],carta) <> true) and (fil < t.columnas[col].tope) do
        fil := fil + 1; {se itera en las filas de una columna hasta que encuentre la carta o llegue a la ultima fila}
  until (sonCartasIguales(t.columnas[col].cartas[fil], carta) = true);
  enQueColumna := col
end;

procedure estanEnAmbos (columna : TColumna; var mazo : TMazo);

var
  fil : 1..FILAS;
  pos,j : 1..N;
  coincidencias : TMazo;

begin
  coincidencias.tope := 0;
  j := 1; {posicion uno del mazo auxiliar}
  for pos := 1 to mazo.tope do {para cada una de las cartas del mazo}
    for fil := 1 to columna.tope do {se compara con todas las cartas de la columna}
      if sonCartasIguales(columna.cartas[fil],mazo.cartas[pos]) then
        begin
          coincidencias.cartas[j] := mazo.cartas[pos]; {las cartas iguales se copian al mazo auxiliar}
          coincidencias.tope := coincidencias.tope + 1;
          j := j + 1 {la var.aux. j itera sobre el mazo coincidencias y solo aumenta de encontrarse alguna coincidencia}
        end;
  mazo := coincidencias;
  coincidencias.tope := 0 {reseteamos coincidencias}
end;

procedure convertirTablero (t : TTablero; var tl : TTableroL);

procedure agregarAlFinal(var l : TColumnaL; cart : TCarta);
var
  listaux,listaux2 : TColumnaL;
begin
  new(listaux); {reservamos espacio de memoria}
  listaux2 := l; {apuntamos listaux2 al inicio de la lista l}
  while (listaux2^.sig <> nil) do {listaux2 va a recorrer l hasta llegar al ultimo nodo de esta}
    listaux2 := listaux2^.sig;
  listaux2^.sig := listaux; {colocamos listaux luego de listaux2 dejando a listaux como ultimo nodo en la lista l}
  listaux^.carta := cart; {colocamos la carta en el final de la lista}
  listaux^.sig := nil {lo volvemos el final de la lista l}
end;

var
  col : 1..COLS;
  fil : 1..FILAS;

begin
  tl.tope := t.tope; {ambos tableros poseen el mismo nro de columnas}
  for col := 1 to tl.tope do {para todas las columnas}
    begin
    new(tl.columnas[col]); //esta instruccion descubri compilando que no era necesaria pero no me queda muy claro el porque.
    tl.columnas[col]^.sig := nil;//sin esta tambien compila y ejecuta bien pero supongo que es porque el compilador debe "setear" en nil por defecto
    tl.columnas[col]^.carta := t.columnas[col].cartas[1]; {se establece la primera carta de cada columna. es decir, la fila 1 del tablero}
    for fil := 2 to t.columnas[col].tope do {toda carta desde la fila 2 hasta la ultima correspondiente se va agregando al final de la (lista)columna}
        agregarAlFinal(tl.columnas[col],t.columnas[col].cartas[fil])
    end
end;
