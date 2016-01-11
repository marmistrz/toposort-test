open OUnit2
open Printf
open Topol
open Topoltools

let () = Random.self_init ()

let print_list l =
    let n = List.length l in
    List.iteri (fun i a -> print_int a; if i <> n-1 then print_string "; ") l
let print_dag l = List.iter (fun (a,b) ->
    printf "%d, [" a; print_list b; print_endline "]") l


let cyclic = [
    (1, [2]);
    (2, [3]);
    (3, [1])]

let l1 = [
    (1, [2]);
    (2, []);
    (3, [2])]
let r1 = topol l1

let l2 = [
    ('a', ['e']);
    ('b', ['a'; 'c']);
    ('c', ['a']);
    ('e', [])]
let r2 = topol l2

let tests =
"tests" >:::
    [
        "t1" >:: (fun _ -> assert_raises Cykliczne (fun () -> topol cyclic));
        "t2" >:: (fun _ -> assert_equal (valid l1 r1) true );
        "t3" >:: (fun _ -> assert_equal (valid l2 r2) true )
    ]

let random = ref false

let bt d o =
    print_dag d; print_list o

let random_tests () =
    let cnt = ref 1 in
    print_endline "Starting random tests..";
    while true do
        let d = random_dag () in
        let out = ref [] in
        try
            out := topol d;
            assert (valid d !out);
            printf "test %d: OK\n" !cnt; flush stdout;
            incr cnt
        with
            | a -> bt d !out; raise (a)
    done

let run_tests () =
    if !random then random_tests ()
    else run_test_tt_main tests

let main () =
    begin
        let speclist = [("-r", Arg.Set random, "Generate random tests forever!")] in
        let usage = "The testing program. Usage:" in
        Arg.parse speclist
            (fun a -> print_endline "Anonymous arguments not allowed!"; Arg.usage speclist usage; exit 1)
            usage;
        run_tests ()
    end

let () = main ()
