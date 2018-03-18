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

let has_empty_word { eow; words } = eow (* ok *)

let rec is_empty { eow; words } = (* ok *)
	if eow then false 
	else let listlex = Iter.to_rev_list (M.to_iter words) in
	let rec aux l = 
		match l with 
	     	   | h::q when q = [] -> let (k,v) = h in is_empty v 
		   | h::q -> let (k,v) = h in is_empty v && aux q 
		   | [] -> true
	in aux listlex


let add word lexicon = (* ok *)
	let taille = String.length word in 
	let rec auxadd ind lexeow lexwords =
		match ind with
		| i when i = taille -> { eow = true;
					  words = lexwords;
						}
		| i -> { eow = lexeow;
			   words = if M.mem (String.get word ind) lexwords then 
					let nextlex = M.find (String.get word ind) lexwords in 
						 M.add (String.get word ind) (auxadd (ind+1) nextlex.eow nextlex.words) lexwords
				   else M.add (String.get word ind) (auxadd (ind+1) false M.empty) lexwords;
			}
	in auxadd 0 lexicon.eow lexicon.words


let appendstr str c = (* ok *) 
	let newstr = Bytes.create ((String.length str) + 1) in
	Bytes.blit (Bytes.of_string str) 0 newstr 0 (String.length str);
	Bytes.set newstr (String.length str) c;
	Bytes.to_string newstr



let rec to_iter { eow; words } = (* ok *) 
	let iterator = ref Iter.empty in 
	let rec aux lex word = 
		if lex.eow then iterator := Iter.cons word !iterator;
		let listlex = Iter.to_rev_list (M.to_iter lex.words) in
		let rec next l = 
			match l with 
			| [] -> ()
			| h::q -> let (k,v) = h in aux v (appendstr word k); next q
		in next listlex;
	in aux { eow; words } "";
	!iterator
	

let letter_suffixes { eow; words } letter = (* ok *)
	let listlex = Iter.to_rev_list (M.to_iter words) in
	let rec findletter l = 
		match l with
		| [] -> { eow = false;
			  words = M.empty;
			}
		| h::q when let (k,v) = h in k = letter -> let (k,v) = h in v
		| h::q -> findletter q
	in findletter listlex


let rec filter_min_length len { eow; words } = (* ok 99% *)
	match len with
	| 0 ->{ eow = eow;
		 words = words;
		}
	| x when is_empty { eow; words } -> { eow = false;
						words = words;
						}
	| x -> { eow = false;
		 words = let newords = ref words in
      let listlex = Iter.to_rev_list (M.to_iter words) in
      let rec aux l = 
	match l with 
	| [] -> ()
	| h::q -> let (k,v) = h in newords := M.add k (filter_min_length (x-1) v) !newords; aux q
      in aux listlex;
      !newords;}
		

let load_file f =
  let rec load_channel channel acc =
    match input_line channel with
    | word -> load_channel channel (add word acc)
    | exception End_of_file -> acc
  in
  match open_in f with
  | channel -> Some (load_channel channel empty)
  | exception Sys_error _ -> None
