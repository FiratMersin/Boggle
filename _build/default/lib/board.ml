open Boggle__Iter
open Boggle__RandomLetter

type t = char array array

let testa = [| [|'a'; 'l'; 's'|]; [|'t'; 'o'; 'i'|]; [|'q'; 't'; 'e'|] |];;

let get_letter board i j = board.(i).(j);;

let dim board = Array.length board;;

let all_positions board =
  failwith "Unimplemented"

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



let neighbours board (i, j) =
  failwith "Unimplemented"

let make dim make_char = let tab = ref (Array.make_matrix dim dim 'k') in
	for i = 0 to dim-1 do 
		for j = 0 to dim-1 do
		   !tab.(i).(j) := 'i'
		done;
	done;
	!tab;;

let from_string s =
  failwith "Unimplemented"

let print board = 
	for i = 0 to Array.length board -1 do
	     for j = 0 to Array.length board -1 do
		print_char board.(i).(j);
		print_string " ";
	     done;
	     print_string "\n";
	done;;

