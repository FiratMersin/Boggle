open Boggle
open Boggle__Board
open Boggle__Iter
open Boggle__RandomLetter



let main () = Random.self_init();
  if Array.length Sys.argv >= 2
  then begin
    print_string "J'ai reçu le paramètre ";
    print_endline Sys.argv.(1);
  end
  else begin
    print_endline "Je n'ai reçu aucun paramètre"
  end;
  print_endline "Je ne sais pas quoi faire... Programmez moi !";
  let smt = from_string "ouiicinon" in
  match smt with
    |Some s -> print s
    |None -> print_string "hello";;

let () = main ()
