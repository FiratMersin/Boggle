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

let rec contain_word wordList word =
	match wordList with
	| [] -> false
	| h::q when h = word -> true
	| h::q -> contain_word q word


let rec add_word wordList word =
	match wordList with
	| [] -> word::[]
	| h::q -> h::(add_word q word)


let iter_to_words board all_paths = 
	let motFound = ref [] in
	let iterWord = ref Iter.empty in
	let list_all_paths = Iter.to_rev_list (all_paths) in
	let rec aux allpth =
		match allpth with
		| [] -> ()
		| h::q -> let newWord = (to_string board h) in
			if (contain_word !motFound newWord)
			then begin aux q end
 			else begin motFound := (add_word !motFound newWord); iterWord := (Iter.cons newWord !iterWord); aux q end
	in aux list_all_paths;
	!iterWord  














