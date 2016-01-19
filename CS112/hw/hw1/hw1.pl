father(al, bud).
father(al, kelly).
mother(peggy, kelly).
mother(peggy, bud).
mother(martha, peggy).

grandma(X,Y) :- mother(X,Z), mother(Z,Y).
