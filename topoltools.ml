exception Buggy

(* adjust these to your needs *)
let v_max = 5000
let e_max = 10000
(* the number of vertices in a random graph *)



type 'a dag = ('a * 'a list) list

let rec find_sublist p l =
    match l with
    | [] -> raise Not_found
    | h::t ->
        if p h then l
        else find_sublist p t

(* find the successors of el *)
let matching el l =
    let _, x = List.find (fun (a,b) -> a = el) l
    in x

let check_one sublist el =
    let found =  List.exists ((=) el) sublist in
    if not found then raise Buggy

let check_successors sublist succ =
    List.iter (check_one sublist) succ

let rec valid src list =
    match list with
    | [] -> true
    | h::t ->
        let succ = matching h src in
        begin
            try
                check_successors t succ;
                valid src t
            with
                Buggy -> false
        end

let swap ar i j =
    let x = ar.(i) in
    ar.(i) <- ar.(j);
    ar.(j) <- x

let shuffle ar =
    let n = Array.length ar in
    for i = n-1 downto 1 do
        let j = Random.int (i+1) in
        swap ar i j
    done

let norm (a,b) =
    (min a b, max a b)

let prepend x l =
    l := (x :: !l)

let adjacency ar =
    let l = ref []
    and n = Array.length ar in
    for i = 0 to n-1 do
        if ar.(i) then prepend i l
    done;
    List.rev !l

let matrix_to_list m =
    let n = Array.length m in
    let ar = Array.init n (fun i -> (i, adjacency m.(i))) in
    shuffle ar;
    Array.to_list ar

let rec random_dag () =
    let v = Random.int v_max in
    let e = Random.int e_max in
    if v = 0 || e = 0 then random_dag ()
    else
        let m = Array.make_matrix v v false in
        for i = 0 to e do
            let x = Random.int v, Random.int v in
            let (i,j) = norm x in
            if i <> j then
                m.(i).(j) <- true
        done;
        matrix_to_list m



