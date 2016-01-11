type 'a dag = ('a * 'a list) list

val valid : 'a dag -> 'a list -> bool
(** `valid spec out` checks whether out is a valid
    topological sort of spec *)

val random_dag : unit -> int dag
