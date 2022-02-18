program myshit;
{==============================================================================}
{==============================================================================}
const
  COLS = 8;
  FILAS = 20;

  N =  COLS * FILAS;

type
  TNumero = 1 .. N div 4;
  TPalo = (copas, bastos, espadas, oros);
  TCarta = record
    case comodin: boolean of
      false : (numero: TNumero; palo: TPalo);
      true : ()
  end;

  TColumna = record
    tope : 0 .. FILAS;
    cartas : array [1 .. FILAS] of TCarta
  end;
  TTablero = record
    tope : 0 .. COLS;
    columnas : array [1 .. COLS] of TColumna
  end;

  TMazo = record
    tope : 0 .. N;
    cartas : array [1..N] of TCarta
  end;

  TRangoCols = 1 .. COLS;
{==============================================================================}
{==============================================================================}

  procedure mostrarCarta(carta:TCarta);
  var
    numero:integer;
    pa:char;
begin
    if carta.comodin = true then
        writeln('J')
    else
        begin
         numero :=carta.numero;
         case carta.palo of
            oros: pa:='o';
            bastos: pa:='b';
            espadas: pa:='e';
            copas:pa:='c';
         end;
        writeln(numero,pa);
        end;
end;

   procedure mostrarTablero (t:TTablero);
var i,j,filas:integer;
  begin
    filas := (5  div t.tope) + 1;
    for i := 1 to filas do
      for j := 1 to t.tope do
        begin
          if t.columnas[j].cartas[i].comodin = true then
            writeln('J')
          else
              mostrarCarta(t.columnas[j].cartas[i])
        end;
  end;
{==============================================================================}
{==============================================================================}
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
  var i,j,k,filas : integer;
  begin
    k := 1;
    t.tope := cantCols;
    filas := (mazo.tope  div cantCols) + 1;
    for i := 1 to filas do
      for j := 1 to t.tope do
        begin
          t.columnas[j].cartas[i] := mazo.cartas[k];
          t.columnas[j].tope := t.columnas[j].tope + 1;
          k := k+1
        end;
  end;


  procedure levantarTablero (t : TTablero; var mazo : TMazo);
var i,j,k :integer;
  BEGIN
    k:=1;
    for i:=1 to t.tope do
      for j:=1 to filas do
        begin
          mazo.cartas[k]:= t.columnas[i].cartas[j];
          k:= k + 1
        end
  END;

  function enQueColumna (carta : TCarta; t: Ttablero): TRangoCols;
var
  i,j : integer;
  begin

  end;

  procedure estanEnAmbos (columna : TColumna; var mazo : TMazo);
begin

end;

procedure convertirTablero (t : TTablero; var tl : TTableroL);
  begin

  end;

{==============================================================================}
{==============================================================================}

var
  opcion : char; { identificador del comando }
  cantcols : 1 .. COLS;
  mazo, mazo2 : TMazo;
  columna : TColumna;
  pos : 1 .. N;
  tablero : TTablero;
  elegida, carta1, carta2, carta3, carta4, carta5, cartaX, cartaY : TCarta;
  Q,K : integer;

{==============================================================================}
{==============================================================================}
begin

  { inicializar el tablero vacío }
  tablero.tope := 0;
  carta1.comodin := true;
  carta2.comodin := true;
  carta3.numero :=5;
  carta3.palo := bastos;
  carta4.numero := 3;
  carta4.palo := oros;
  carta5.numero := 3;
  carta5.palo := oros;

 { MAZO 1
 mazo.tope := 5;
  mazo.cartas[1].comodin:= true;
  mazo.cartas[2].comodin:= true;
  mazo.cartas[3].numero:= 5;
  mazo.cartas[4].numero:=3;
  mazo.cartas[5].numero:=3;
  mazo.cartas[3].palo:= bastos;
  mazo.cartas[4].palo:= oros;
  mazo.cartas[5].palo:= oros;}

{  MAZO 2
mazo.tope := 5;
  mazo.cartas[1].numero:=4;
  mazo.cartas[1].palo:= oros;
  mazo.cartas[2].numero:=1;
  mazo.cartas[2].palo:= bastos;
  mazo.cartas[3].numero:= 5;
  mazo.cartas[4].numero:=3;
  mazo.cartas[5].numero:=9;
  mazo.cartas[3].palo:= bastos;
  mazo.cartas[4].palo:= espadas;
  mazo.cartas[5].palo:= copas;}


{==================================}

  repeat
    read (opcion);

    case opcion of

    's': { son cartas iguales }
        {leerCarta(carta1); leerCarta (carta2);}
      begin
        read(Q,K);
        case Q OF
          1 : cartaX := carta1;
          2 : cartaX := carta2;
          3 : cartaX := carta3;
          4 : cartaX := carta4;
          5 : cartaX := carta5;
        END;
        CASE K of
         1 : cartaY := carta1;
         2 : cartaY := carta2;
         3 : cartaY := carta3;
         4 : cartaY := carta4;
         5 : cartaY := carta5;
        end;
        if sonCartasIguales (cartaX,cartaY) then
          writeln ('Las cartas son iguales')
        else
          writeln ('Las cartas NO son iguales')
      end;
      'm': { desplegar el mazo en el tablero }
        begin
          read (cantCols);
        { leerMazo (mazo);}
          armarTablero (mazo, cantCols, tablero);
          writeln('armado');
          mostrarTablero(tablero);
          writeln('mostrado');
        end;

    end

  until opcion = 'q';

end.

      'm': { desplegar el mazo en el tablero }
        begin
          read (cantCols);
          leerMazo (mazo);
          armarTablero (mazo, cantCols, tablero);
          writeln()
        end;

      't':
        mostrarTablero (tablero);

      'l': { levantar el tablero }
        begin
          levantarTablero (tablero, mazo2);
          mostrarMazo (mazo2);
        end;

      'b': { buscar en que columna está la carta elegida. }
        begin
          if mazo.tope = 0 then
            writeln ('No se ha creado el mazo.')
          else
          begin
            read (pos);
            if pos > mazo.tope then writeln ('La posición elegida está fuera de rango.')
            else
              writeln ('Está en la columna ', enQueColumna (mazo.cartas[pos], tablero):1)
          end
        end;

      'e': { estanEnAmbas }
        begin
          leerColumna (columna);
          leerMazo (mazo2);
          estanEnAmbos (columna, mazo2);
          if mazo2.tope = 0 then
            writeln('Ninguna carta están en ambos.')
          else
            begin
              write ('Los que están en ambos son ');
              mostrarMazo (mazo2)
            end
        end;

      'a': { adivinar }
        begin
          read (cantCols);
          leerMazo (mazo2);
          leerCarta (elegida);
          adivinar (mazo2, cantCols, elegida)
        end;

      'c': { convertir }
        begin
          convertirTablero (tablero, tableroL);
          mostrarTableroL (tableroL)
        end;

    end

  until opcion = 'q';

end.
