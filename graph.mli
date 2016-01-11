type 'a graph
val init : 'a list -> 'a graph
val size : 'a graph -> int
val add_directed : 'a graph -> int -> int -> unit
val add : 'a graph -> int -> int -> unit
val neighbors : 'a graph -> int -> int list
val indeg : 'a graph -> int -> int
val decr_indeg : 'a graph -> int -> unit
