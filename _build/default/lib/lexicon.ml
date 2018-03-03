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

let has_empty_word { eow; words } = let listkv = Iter.to_rev_list (M.to_iter words) in 
	let rec aux l = match l with
		| [] -> false
		| h::q when let (k,v) = h in k = ' ' -> true (* ' ' = vide *)
		| h::q -> aux q
	   in aux listkv;;
	

let rec is_empty { eow; words } = if eow then false (* a tester *)
	else let listlex = Iter.to_rev_list (M.to_iter words) in
	let rec aux l = 
		match l with 
	     	   | h::q when q = [] -> let (k,v) = h in is_empty v
		   | h::q -> let (k,v) = h in is_empty v; aux q
		   | [] -> true (* pb ? parcourt tout l'arbre avant de retourner true ? *)
	in aux listlex;;


let add word lexicon = let newlex = ref empty in 
	(!newlex).words = lexicon.words;
	let taille = String.length word in
	let rec auxadd ind words =
	let listkv = Iter.to_rev_list (M.to_iter words) in 

		let rec aux l = match l with 
			| [] -> M.add (String.get word ind) empty ((!newlex).words)	 
			| h::q -> let (k,v) = h in if k = word.(0) then print_int 1
			| h::q -> aux q 
		in aux listkv;
	in auxadd 0 (!newlex).words;
	!newlex;;

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
