(*
   Fournit une extension qui colore le texte du contenu.
   Exemple d'utilisation:
     <<colored color="blue" | **I'm bold and blue.**>>
   produit:
     <div style="color: blue"><strong>I'm bold and blue.</strong></div>
*)

(** Fonction produisant le code HTML de l'extension "colored". *)
let create_colored_text _ args content =
  let color = Ocsimore_lib.get_opt "color" in
  Tyxml.Html.(div ~a:[a_style ("color: " ^ color)]
                content)

(* Enregistement de l'extension auprès du compilateur. *)
let () =
  Wiki_syntax.register_simple_extension
    Wiki_syntax.wikicreole_parser (* analyseur syntaxique du contenu *)
    "colored" (* nom de l'extension *)
    create_colored_text (* fonction à appeler *)
