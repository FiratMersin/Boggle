type t = char array array

let testa = [| [|'a'; 'l'; 's'|]; [|'t'; 'o'; 'i'|]; [|'q'; 't'; 'e'|] |];;(* pour test *)

let get_letter board i j = board.(i).(j);;

let dim board = Array.length board;;

let all_positions board = let taille = Array.length board in 
	let iteri = ref Iter.empty in
	for i = 0 to taille -1 do
		iteri := Iter.cons i !iteri
	done;
	let iterator = Iter.product !iteri !iteri in 
	iterator;;

let are_neighbours board (i, j) (i', j') = match (i,j) with
	| (i,j) when i-1 = i' && j-1 = j' -> true
	| (i,j) when i-1 = i' && j = j' -> true
	| (i,j) when i-1 = i' && j+1 = j' -> true
	| (i,j) when i = i' && j-1 = j' -> true
	| (i,j) when i = i' && j+1 = j' -> true
	| (i,j) when i+1 = i' && j-1 = j' -> true
	| (i,j) when i+1 = i' && j = j' -> true
	| (i,j) when i+1 = i' && j+1 = j' -> true
	| (_,_) -> false;;
  

let is_valid_pos board (i, j) = match (i,j) with
	| (i,j) when i >= Array.length board || i < 0 -> false
	| (i,j) when j >= Array.length board || j < 0 -> false
	| (_,_) -> true;;



let neighbours board (i, j) = let iteri = ref Iter.empty in
	if (is_valid_pos board (i-1, j-1)) then iteri := Iter.cons (i-1, j-1) !iteri;
	if (is_valid_pos board (i-1, j)) then iteri := Iter.cons (i-1, j) !iteri; 
	if (is_valid_pos board (i-1, j+1)) then iteri := Iter.cons (i-1, j+1) !iteri; 
	if (is_valid_pos board (i, j-1)) then iteri := Iter.cons (i, j-1) !iteri; 
	if (is_valid_pos board (i, j+1)) then iteri := Iter.cons (i, j+1) !iteri; 
 	if (is_valid_pos board (i+1, j-1)) then iteri := Iter.cons (i+1, j-1) !iteri; 
	if (is_valid_pos board (i+1, j)) then iteri := Iter.cons (i+1, j) !iteri; 
	if (is_valid_pos board (i+1, j+1)) then iteri := Iter.cons (i+1, j+1) !iteri;
	!iteri;; 
 

let make dim make_char = let tab = ref (Array.make_matrix dim dim 'k') in (* donner par default make_char pour freq lang fr *) 
	for i = 0 to dim-1 do 
		for j = 0 to dim-1 do
		   !tab.(i).(j) <- RandomLetter.make_char()
		done;
	done;
	!tab;;

let print board = 
	for i = 0 to Array.length board -1 do
	     for j = 0 to Array.length board -1 do
		print_char board.(i).(j);
		print_string " ";
	     done;
	     print_string "\n";
	done;;


let get_char_pos board i j = board.(i).(j)


let from_string s = let taille = String.length s in
    let sqrtint = int_of_float (sqrt (float_of_int taille)) in
  	if sqrtint*sqrtint != taille then None else
	     let tab = ref (Array.make_matrix sqrtint sqrtint 'k') in
		let ind = ref 0 in
	         for i = 0 to sqrtint-1 do
	              for j = 0 to sqrtint-1 do
		           !tab.(i).(j) <- s.[!ind];
			   ind := !ind + 1;
		      done;
		done;
		Some !tab;;

 



