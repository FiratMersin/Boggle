exception ArgumentException
exception FileException

let get_lex () = let lex = Boggle.Lexicon.load_file "dict/dico_fr.txt" in
	match lex with
	| None -> raise FileException
	| Some l -> print_string "Chargement et filtrage de dico_fr.txt\n\n"; Boggle.Lexicon.filter_min_length 3 l 

let get_board_string chaine = let board = Boggle.Board.from_string chaine in
	match board with
	| None -> raise ArgumentException
	| Some b -> b

let wait_press_enter ()= print_string "Veuillez appuyer sur la touche Entrée\n";
	let x = read_line() in print_string x 

let compare_word wordA wordB = String.compare wordA wordB 

let rec get_taille_word taille wordlist = 
	match wordlist with
	| [] -> []
	| h::q when (String.length h) = taille -> h::(get_taille_word taille q)
	| h::q -> get_taille_word taille q

let rec tri_par_taille taille wordlist = 
	match taille with
	| 2 -> []
	| x -> (get_taille_word x wordlist)::(tri_par_taille (x-1) (wordlist))

let rec sort_all lists = 
	match lists with
	| [] -> []
	| h::q -> (List.sort compare_word h)::(sort_all q)
	
	
let get_length_max_word wordlist = 
	let rec aux max l =
	   match l with
	   | [] -> max
	   | h::q when (String.length h) > max -> aux (String.length h) q
	   | h::q -> aux max q
	in aux 0 wordlist



let print_all_solution worditer = 
	let wordlist= Boggle.Iter.to_rev_list worditer in 
	print_string "Voici les ";print_int (List.length wordlist); 
	print_string " solutions :\n";
	let tailleMax = get_length_max_word wordlist in
	let sortedlists = sort_all (tri_par_taille tailleMax wordlist) in

	let rec affiche lists =
	match lists with
	| [] -> ()
	| h::q -> print_newline (); let rec aux l =
		  match l with 
		  | [] -> ()
		  | h::q -> print_endline h; aux q
		  in aux h; affiche q
	in affiche sortedlists

let main () =
try

  let lex = get_lex () in
  if Array.length Sys.argv >= 2
  then begin
    let myboard = get_board_string Sys.argv.(1) in
    print_string "Voici la grille :\n"; Boggle.Board.print myboard; print_newline();
    wait_press_enter ();
    let iterSoluce = Boggle.Path.iter_to_words myboard (Boggle.Solver.find_all_paths myboard lex) in
    print_all_solution iterSoluce;
  end
  else begin
    let myboard = Boggle.Board.make 4 Boggle.RandomLetter.make_char in
    print_string "Voici la grille :\n"; Boggle.Board.print myboard; print_newline();
    wait_press_enter ();
    let iterSoluce = Boggle.Path.iter_to_words myboard (Boggle.Solver.find_all_paths myboard lex) in
    print_all_solution iterSoluce;
  end;
 
with
	| ArgumentException -> print_string "Erreur argument : chaîne de caractères\n"
	| FileException -> print_string "Erreur lecture fichier dictionnaire\n"

let () = main ()
