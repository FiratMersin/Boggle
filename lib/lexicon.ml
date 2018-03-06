 	module M = struct
  include Map.Make (Char)

  let to_iter s =
    fun k ->
      iter (fun key item -> k (key, item)) s
end

type t = {
  eow : bool;
  words : t M.t;
}

let empty =
  (* Cette valeur vous est donnée, vous n'avez pas besoin de l'écrire
     vous-même. *)
  {
    eow = false;
    words = M.empty;
  }

let endWord = 
  {
    eow = true;
    words = M.empty;
  }

let changeValueField lex eowV wordsV = let tmp = {eow = eowV ; words = wordsV } in tmp;;

let changeEnd lex = 
	changeValueField lex true lex.words;;

let has_empty_word { eow; words } = let listkv = Iter.to_rev_list (M.to_iter words) in 
	let rec aux l = match l with
		| [] -> false
		| h::q when let (k,v) = h in k = ' ' -> true (* ' ' = vide *)
		| h::q -> aux q
	   in aux listkv;;
	

let rec is_empty { eow; words } = (*M.is_empty words;;*)

		if eow then false 
	else let listlex = Iter.to_rev_list (M.to_iter words) in
	let rec aux l = 
		match l with 
	     	   | h::q when q = [] -> let (k,v) = h in is_empty v
		   | h::q -> let (k,v) = h in is_empty v; aux q
		   | [] -> true (* pb ? parcourt tout l'arbre avant de retourner true ? *)
	in aux listlex;;


let add word lexicon = (*
	let taille = String.length word in
	let rec auxadd ind words =
	let listkv = Iter.to_rev_list (M.to_iter words) in 

		let rec aux l = match l with 
			| [] -> M.add (String.get word ind) empty words;
			| h::q when let (k,v) = h in k = (String.get word ind) -> let (k,v) = h in auxadd (ind+1) v;
			| h::q -> aux q; 
		in aux listkv;
	in auxadd 0 lexicon.words;
	lexicon;;*)

	let taille = String.length word in 
	let rec auxadd i auxwords = match i with
		| x when x = taille -> lexicon
		
		| _ ->	let listkv = Iter.to_rev_list (M.to_iter auxwords) in 
				let rec aux l = match l with
					| [] -> if i = (taille-1) then let tmpval = endWord in M.add (String.get word i) tmpval auxwords; auxadd (i+1) tmpval.words;
					else let tmpval = empty in  M.add (String.get word i) empty auxwords; auxadd (i+1) tmpval.words; 
					| h::q when let (k,v) = h in k = (String.get word i) -> let (k,v) = h in auxadd (i+1) v.words;
					| h::q -> aux q;
				in aux listkv;
	in auxadd 0 lexicon.words;; (* A TESTER *)





let rec to_iter { eow; words } =
  failwith "Unimplemented"

let letter_suffixes { eow; words } letter =
  failwith "Unimplemented"

let rec filter_min_length len { eow; words } =
  failwith "Unimplemented"

let load_file f =
  let rec load_channel channel acc =
    match input_line channel with
    | word -> load_channel channel (add word acc)
    | exception End_of_file -> acc
  in
  match open_in f with
  | channel -> Some (load_channel channel empty)
  | exception Sys_error _ -> None
