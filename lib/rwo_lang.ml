open Core
open Async

type t = string
  [@@deriving sexp]

let to_string = Fn.id

let of_string x = match x with
  | "ascii"
  | "atd"
  | "c"
  | "cmd"
  | "cpp"
  | "errsh"
  | "h"
  | "java"
  | "json"
  | "ml"
  | "mli"
  | "mll"
  | "mlpack"
  | "mly"
  | "out"
  | "rawscript"
  | "rawsh"
  | "S" | "s"
  | "scm"
  | "sh"
  | "syntax"
  | "topscript"
  | "txt" -> Ok x
  | _ -> error "invalid extension" x sexp_of_string

let of_filename filename =
  match Filename.split_extension filename with
  | _, Some ext -> of_string ext
  | _, None ->
     error
       "cannot infer lang of filename without extension"
       filename sexp_of_string

let to_docbook_lang t = match t with
  | "atd"   -> Ok "ocaml"
  | "cmd"   -> Ok "bash"
  | "c"     -> Ok "c"
  | "h"     -> Ok "c"
  | "out"   -> Ok "console"
  | "cpp"   -> Ok "c"
  | "S"
  | "s"     -> Ok "gas"
  | "java"  -> Ok "java"
  | "json"  -> Ok "json"
  | "ml"
  | "mli"   -> Ok "ocaml"
  | "scm"   -> Ok "scheme"
  | _ -> error "language not supported by docbook" t sexp_of_t