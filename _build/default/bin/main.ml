open Boggle
open Boggle__Board
open Boggle__Iter
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
  print (make 3 make_char);;

let () = main ()
