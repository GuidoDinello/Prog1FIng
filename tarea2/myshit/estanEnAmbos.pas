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
  fil : 0..FILAS;
  pos,c,j : 0..N;
  coincidencias : TMazo;

begin
    coincidencias.tope := 0;
    j := 1; {posicion uno del mazo auxiliar}
    for pos := 1 to mazo.tope do {para cada una de las cartas del mazo}
      for fil := 1 to columna.tope do {se compara con todas las cartas de la columna}
        if sonCartasIguales(columna.cartas[fil],mazo.cartas[pos]) then
          begin
            pasaCarta(mazo.cartas[pos],coincidencias.cartas[j]); {si son iguales se copia la carta al mazo auxiliar: coincidencias}
            coincidencias.tope := coincidencias.tope + 1;
            j := j + 1; {la var.aux. j itera sobre el mazo coincidencias y solo aumenta de encontrarse alguna coincidencia}
          end;
          mazo := coincidencias;
    //mazo.tope := coincidencias.tope; {la idea es volver el mazo principal igual a el auxiliar que contiende solo las coincidencias en el orden adecuado}
//    for c := 1 to coincidencias.tope do
    //    pasaCarta(coincidencias.cartas[c],mazo.cartas[c]); {se copia cada carta de coincidencias a el mazo principal}
    coincidencias.tope := 0; {reseteamos coincidencias}
end;
