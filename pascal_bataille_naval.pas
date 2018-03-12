program bataille_naval;

uses crt;

const
	caseMaxBateau=3;
	nbMaxBateau=3;
	nbMaxLigne=30;
	nbMaxColonne=30;

type cell = record
	l : integer;
	c : integer;
end;

type bateau = record
	nCase : array [1..caseMaxBateau] of cell;
	degat : integer;
end;

type flotte = record
	nBateau : array [1..nbMaxBateau] of bateau;
	nbBateauCouler : integer
end;
//Création des case
procedure creationCase (l,c:integer;VAR nCell:cell);
	begin
		nCell.l:=l;
		nCell.c:=c;
	end;

function comparerCell(nCell,tCell:cell) : boolean;
		begin
			comparerCell:=FALSE;

			if ((nCell.c=tCell.c) and (nCell.l=tCell.l)) then
				begin
					comparerCell:=TRUE;
				end;
		end;

function creationBateau(nCell : cell) : bateau;
	var
		i : integer;
		bat : bateau;
	begin
		for i:=1 to caseMaxBateau do
			begin
				//bateau uniquement en ligne
				bat.nCase[i].l := nCell.l;
				bat.nCase[i].c := nCell.c+i;
			end;
		creationBateau:=bat;
	end;

procedure creationFlotte (var nBateau:bateau; var nCell:cell; var joueur:flotte);
	var	
		i,j : integer;

	begin
		for i:=1 to nbMaxBateau do
			begin
			creationCase((Random(nbMaxLigne)),(Random(nbMaxColonne - caseMaxBateau)),nCell);

			joueur.nBateau[i]:=creationBateau(nCell);
			end;
	end;

procedure tourJoueur (var joueur:flotte; var perdu : boolean);
	var
		cellJoueur : cell;
		i, j : integer;
		reussi : boolean;
	begin
		writeln('Entrer la ligne entre 1 et ', nbMaxLigne);
		readln(cellJoueur.l);
		 while (cellJoueur.l < 0) or (cellJoueur.l > nbMaxLigne) do
		 	begin
		 		writeln('Erreur entrer un nombre entre 1 et ', nbMaxLigne);
		 		readln(cellJoueur.l);
		 	end;

		writeln('Entrer la colonne entre 1 et ', nbMaxColonne);
		readln(cellJoueur.c);
		 while (cellJoueur.c < 0) or (cellJoueur.c > nbMaxLigne) do
		 	begin
		 		writeln('Erreur entrer un nombre entre 1 et ', nbMaxColonne);
		 		readln(cellJoueur.c);
		 	end;

		for i:=1 to nbMaxBateau do
			begin
				for j:=1 to caseMaxBateau do
				reussi := FALSE;
				reussi := comparerCell(cellJoueur,joueur.nBateau[i].nCase[j]);

				if reussi then
					begin
						writeln('TOUCHE!');
						joueur.nBateau[i].degat := joueur.nBateau[i].degat + 1;
					
						if (joueur.nBateau[i].degat = caseMaxBateau) then
							begin
								writeln('COULER!');
								joueur.nbBateauCouler := joueur.nbBateauCouler + 1;

								if (joueur.nbBateauCouler = nbMaxBateau) then
									begin
										perdu:=TRUE
									end;
							end;
					end;
			end;
	end;


var
	nCell : cell;
	j1, j2 : flotte;
	perdu : boolean;
	j1gagnant : boolean;
	nBateau : bateau;
begin
	clrscr;
	randomize;
	perdu:=FALSE;
	

	//Inisiatitation du joueur 1
	creationFlotte(nBateau, nCell, j1);
	//Inisiatitation du joueur 2
	creationFlotte(nBateau, nCell, j2);

	repeat
		
		j1gagnant:=FALSE;
		if (perdu = FALSE) then
			begin
				writeln('tour du joueur 1');
				tourJoueur (j1, perdu);
				j1gagnant:=TRUE;
			end;


		if (perdu = FALSE) then
			begin
				writeln('tour du joueur 2');
				tourJoueur (j2, perdu);

			end;
	until (perdu = TRUE);

	if (j1gagnant = TRUE) then
		writeln('BRAVO !!! joueur 1 a gagner.')
	else
		writeln('BRAVO !!! joueur 2 a gagner.');

		readln;


end.