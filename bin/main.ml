open Boggle
open Boggle__Board
open Boggle__RandomLetter



let main () =
  if Array.length Sys.argv >= 2
  then begin
    print_string "J'ai reçu le paramètre ";
    print_endline Sys.argv.(1);
  end
  else begin
    print_endline "Je n'ai reçu aucun paramètre"
  end;
  print_endline "Je ne sais pas quoi faire... Programmez moi !";
  (*let iter = neighbours testa (0,0) in
  let mylist = Iter.to_rev_list iter in   
  (*print_int (List.length mylist);*)
  let (x,y) = (List.nth mylist 2) in
  print_int x;
  print_int y;;*)
  (*let tab = make 4 make_char in
  print tab;;*)
  (*let lex = Lexicon.add "a" Lexicon.empty in
	let lexb = Lexicon.add "ar" lex in
	let lexc = Lexicon.add "ara" lexb in
	let lexd = Lexicon.add "arab" lexc in
	let lexe = Lexicon.add "araba" lexd in
	let lexmin = Lexicon.filter_min_length 3 lexe in
  	let vf = Lexicon.is_empty lexmin in
		if vf then print_string "vrai\n" else print_string "faux\n";
	let iterateword = Lexicon.to_iter  lexmin in
	Iter.iter print_string iterateword;
	let emptyw = Lexicon.has_empty_word (Lexicon.letter_suffixes lexe 'a') in
		if emptyw then print_string "mot vide found\n" else print_string "pas de mot vide\n";;*)
 (* let optlex = Lexicon.load_file "dict/dico_fr_petit.txt" in 
  match optlex with 
	| None -> None
	| l -> let vf = Lexicon.is_empty l in
		if vf then print_string "vrai\n" else print_string "faux\n";;*)
  let p = Path.add_tile testa Path.empty (0, 0) in
 let px = (match p with | None -> Path.empty
 	| Some z -> z) in
   let pp = Path.add_tile testa px (1,1) in
	let path = (match pp with | None -> Path.empty
						| Some z -> z) in
   let ppp = Path.add_tile testa path (2,2) in
	let pathh = (match ppp with | None -> Path.empty
						| Some z -> z) in
	let mot = Path.to_string testa pathh in 
	print_string mot; print_string "\n";;





  

let () = main ()
