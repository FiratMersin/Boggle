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
  (*let lex = Lexicon.add "azr" Lexicon.empty in
  	let vf = Lexicon.is_empty lex in
		if vf then print_string "vrai\n" else print_string "faux\n"*);;
  

let () = main ()
