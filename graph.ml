type 'a graph =
{
    n : int;
    v : 'a array;
    e : int list array;
    indeg : int array
}

let init li =
    let ar = Array.of_list li in
    let l = Array.length ar in
    {
        n = l;
        e = Array.make l [];
        v = ar;
        indeg = Array.make l 0
    }

let size g = g.n

let add_directed g x y =
    g.e.(x) <- y::g.e.(x);
    g.indeg.(y) <- g.indeg.(y) + 1

let add g x y =
    add_directed g x y;
    add_directed g y x

let neighbors g x =
    g.e.(x)

let indeg g x =
    g.indeg.(x)

let decr_indeg g x =
    g.indeg.(x) <- g.indeg.(x) - 1
