module day1part1

//Imports.//
import std/core
import std/os/file
import std/os/path
////////////


//Helper functions.//
//chunksof -> Split a list into chunks.//
fun chunksof ( l : list<a> , c : int ) : div list<list<a>>
  match l
    []  -> []
    [_] -> []
    xs  -> xs.take(c).single
           ++
           xs.drop(c - 1).chunksof(c)

//allthesame -> Determine is a list contains only one element.
fun allthesame (l : list<int>) : bool
  match l
    [] -> True
    xs -> all(xs.tail,fn (x) if xs.head(0) == x
                               then True
                               else False
             )

//samesum -> Sum a list composed only of sublists containing identical elements.
fun samesum (l : list<list<int>>) : int
  match l
    [] -> 0
    xs -> xs.map(fn (ls)
                  if ls.allthesame
                    then head(ls,0)
                    else 0
                )
            .sum
/////////////////////


//Main function.//
pub fun main()
  val inputfile   = "/Users/4473117/Software/local/koka/advent-of-code/2017" / "day1/input.txt"
  val chunkedlist = head(inputfile.read-text-file.lines.filter(is-notempty),"")
                    .list
                    .map(single)
                    .map(string)
                    .map(fn(s) s.parse-int-default)
                    .chunksof(2)
  val finallist   = chunkedlist
                    ++
                    (chunkedlist.last([]).last(0).single
                     ++
                     chunkedlist.head([]).head(0).single
                    ).single
  val answer      = finallist.samesum
  println("The answer to advent of code 2017 day 1, part 1 is: " ++ answer.show)
//////////////////
