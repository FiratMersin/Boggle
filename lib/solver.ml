(* backtrack : Board.t -> Lexicon.t -> Path.t -> int * int -> Path.t Iter.t *)
let rec backtrack board lexicon path (i, j) =  
	let solution_chemin_courant = ref Iter.empty in
  	let pathtmp = Path.add_tile board path (i, j) in
  	match pathtmp with
	| Some x -> 
		let pathPrim = x in
		let alpha = Board.get_letter board i j in
		let lexiconPrim = Lexicon.letter_suffixes lexicon alpha in
		if Lexicon.is_empty lexiconPrim then Iter.empty

		else begin match (Lexicon.has_empty_word lexiconPrim)  with
			| true -> solution_chemin_courant := Iter.cons pathPrim !solution_chemin_courant;
				let itallvoisins = (Board.neighbours board (i, j)) in
				let listallvoisins = (Iter.to_rev_list itallvoisins) in
				
				let solution_via_voisin = ref Iter.empty in
				for i = 0 to (List.length listallvoisins -1) do
		    		  solution_via_voisin := Iter.append !solution_via_voisin (backtrack board lexiconPrim pathPrim (List.nth listallvoisins i))
				done;
				let res = Iter.append !solution_chemin_courant !solution_via_voisin in 
				res
			| false -> solution_chemin_courant := Iter.empty;
				let itallvoisins = (Board.neighbours board (i, j)) in
				let listallvoisins = (Iter.to_rev_list itallvoisins) in
				let solution_via_voisin = ref Iter.empty in
				for i = 0 to (List.length listallvoisins -1) do
		    		  solution_via_voisin := Iter.append !solution_via_voisin (backtrack board lexiconPrim pathPrim (List.nth listallvoisins i))
				done;
				let res = Iter.append !solution_chemin_courant !solution_via_voisin in
				res
		     end			
	| None -> Iter.empty




let find_all_paths board lexicon =
  let itall = ref Iter.empty in
  let itallpos = Board.all_positions board in
  let listallpos = Iter.to_rev_list itallpos in
  for i = 0 to (List.length listallpos -1) do
	itall := Iter.append !itall (backtrack board lexicon Path.empty (List.nth listallpos i)); 
  done;
  !itall
