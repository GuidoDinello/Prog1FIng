procedure levantarTablero (t: TTablero; var mazo: TMazo);
var
  col : 0..COLS;
  fil : 0..FILAS;
  pos : 0..N;
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


{ Determina en que columna de 't' está 'carta'.
  Se puede asumir que 'carta' está en el tablero 't'.
  Se puede asumir que en t no hay cartas repetidas. }
function enQueColumna (carta : TCarta; t: TTablero): TRangoCols;
var
  fil : 0..FILAS;
  col : 0..COLS;
begin
  col := 0;
  repeat
      fil := 1; {se actualiza fila a 1 para que empiece a buscar en la fila 1 de la siguiente columna}
      col := col + 1; {se avanza en las columnas}
      while (sonCartasIguales(t.columnas[col].cartas[fil],carta) <> true) and (fil < t.columnas[col].tope) do
        fil := fil + 1; {se itera en las filas de una columna hasta que encuentre la carta o llegue a la ultima fila}
  until (sonCartasIguales(t.columnas[col].cartas[fil], carta) = true);
  enQueColumna := col
end;


{ Deja en 'mazo' solo las cartas que también están en 'columna'.
  Las cartas quedan en el mismo orden relativo en que estaban. }
procedure estanEnAmbos (columna : TColumna; var mazo : TMazo);

procedure pasaCarta(m1 : TCarta; var m2 : TCarta);
begin
  if m1.comodin = true then
    m2.comodin := true
  else
    begin
      m2.comodin := false;
      m2.numero := m1.numero;
      m2.palo := m1.palo
    end;
end;

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
            coincidencias.cartas[j] := mazo.cartas[pos];
          //  pasaCarta(mazo.cartas[pos],coincidencias.cartas[j]); {si son iguales se copia la carta al mazo auxiliar: coincidencias}
            coincidencias.tope := coincidencias.tope + 1;
            j := j + 1; {la var.aux. j itera sobre el mazo coincidencias y solo aumenta de encontrarse alguna coincidencia}
          end;
          mazo := coincidencias;
    coincidencias.tope := 0; {reseteamos coincidencias}
end;
