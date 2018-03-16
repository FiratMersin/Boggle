(** Chemins sur une grille. Un chemin est une séquence de cases
    valides de la grille qui respecte les deux invariants suivants :

    - Deux cases consécutives dans le chemin sont voisines sur la grille.
    - Toute case de la grille est présente au plus une fois dans le chemin.

    Tout chemin construit à l'aide des fonctions fournit dans ce
    module garantit de respecter ces deux invariants.
*)

exception InvariantsException

type t = (int * int) list

let empty = []

let getnth i path = List.nth path i (* fun for test *)

let add_tile board path (i, j) = (* on suppose ici que (i,j) est une case de board *)
  try
     let rec aux chemin = 
	match chemin with 
	| [] -> (i,j)::[]
        | h::q when q = [] && (h = (i,j) || (Board.are_neighbours board (i, j) h)) = false -> raise InvariantsException
        | h::q when h = (i,j) -> raise InvariantsException
        | h::q -> h::(aux q)
     in Some (aux path)	
  with
   | InvariantsException -> None
	

let appendstr str c = 
	let newstr = Bytes.create ((String.length str) + 1) in
	Bytes.blit (Bytes.of_string str) 0 newstr 0 (String.length str);
	Bytes.set newstr (String.length str) c;
	Bytes.to_string newstr

let rec to_string board path =
  let rec aux p word =
	match p with
	| [] -> word
	| h::q -> let (i,j) = h in aux q (appendstr word (Board.get_char_pos board i j))
  in aux path ""

let iter_to_words board all_paths =
  failwith "Unimplemented"
