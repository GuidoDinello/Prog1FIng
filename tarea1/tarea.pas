function generadora (n: integer): integer;

var
  a,b : integer;
  digito : array[0..2] of integer;

procedure ordenDes (var arr: array of integer);
var i : integer;

procedure cambia (var a1,a2: integer);
var aux : integer;
begin
  {cambia los valores usando el pivote aux}
  aux := a1;
  a1 := a2;
  a2 := aux;
end;

begin
  for i := 0 to 1 do
    {ordena d1d2 y d2d3, ej.123-213-231}
    if arr[i] < arr[i+1] then
      cambia(arr[i],arr[i+1]);
    {establece la ultima relacion d1d3, ...-321 }
    if arr[0] < arr[1] then
      cambia(arr[0],arr[1])
end;

begin
  {calculo explicitamente los digitos de n}
  digito[0] := n mod 10;
  digito[1] := (n div 10) mod 10;
  digito[2] := (n div 100);
  {ordeno de forma descendiente el array}
  ordenDes(digito);
  {calculo a y b}
  a := digito[0]*100 + digito[1]*10 + digito[2];
  b := digito[2]*100 + digito[1]*10 + digito[0];
  {genera}
  generadora := a - b;
end;

function longitud (semilla: integer; limite: integer): integer;

var long,act,sig : integer;
begin
  {inicializo en 1 dado que esta es la posicion de la semilla}
  long := 1;
  {semilla es el valor actual y siguiente su imagen funcional}
  act := semilla;
  sig := generadora(act);
  while (act <> sig) and (long <= limite) do
    begin
      {suma uno a la longitud dado que g(n)<>g(g(n))}
      long := long + 1;
      {actualizo los valores a comparar}
      act := sig;
      sig := generadora(sig)
    end;
  {control de caso}
  if (long > limite) then
    long := -1;
  {obtengo longitud}
  longitud := long;
end;
