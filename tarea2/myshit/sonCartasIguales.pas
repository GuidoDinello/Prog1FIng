function sonCartasIguales (a, b : TCarta) : boolean;
begin
  if a.comodin and b.comodin then {ambos comodines}
    sonCartasIguales := TRUE
  else
    if (not a.comodin) and (not b.comodin) then {ambos no comodines}
        sonCartasIguales := (a.numero = b.numero) and (a.palo = b.palo) {si tienen las mismas propiedades true sino false}
    else sonCartasIguales := false {si alguna es comodin y la otra no}
end;
