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

let add_tile board path (i, j) = (* on suppose ici que (i,j) est une case de board *)
  let (x,y) = List.nth path 0 in 
	print_int x;print_int y;print_string "\n";
	Some path
	

let rec to_string board path =
  failwith "Unimplemented"

let iter_to_words board all_paths =
  failwith "Unimplemented"
