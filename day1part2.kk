module day1part2

//Imports.//
import std/core
import std/os/file
import std/os/path
////////////


//Helper functions.//
//allthesame -> Determine is a list contains only one element.
fun allthesame (l : list<int>) : bool
  match l
    [] -> True
    xs -> all(xs.tail,fn (x) if xs.head(0) == x
                               then True
                               else False
             )

//generatecorrectpairs -> Generate correct pairing according to
//the length of the input list.
fun generatecorrectpairs ( lz : list<(int,int)>
                         , v  : vector<int>
                         , len : int = v.length     
                         , lendivtwo : int = v.length / 2
                         ) : list<list<int>>
  match lz
    []            -> []
    [_]           -> []
    Cons (x , xs) -> match (x.fst + lendivtwo) > len
                       True  -> match v.at((x.fst - lendivtwo) - 1)
                                  Just(value) -> ((x.snd.single ++ value.single).single)
                                                 ++
                                                 xs.generatecorrectpairs(v)
                                  Nothing     -> xs.generatecorrectpairs(v)
                       False -> match v.at(x.fst + lendivtwo - 1)
                                  Just(value) -> ((x.snd.single ++ value.single).single)
                                                 ++
                                                 xs.generatecorrectpairs(v)
                                  Nothing     -> xs.generatecorrectpairs(v)

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
  val inputfile       = "/Users/4473117/Software/local/koka/advent-of-code/2017" / "day1/input.txt"
  val finallist       = head(inputfile.read-text-file.lines.filter(is-notempty),"")
                        .list
                        .map(single)
                        .map(string)
                        .map(fn(s) s.parse-int-default)
  val finallistzipped = list(1,finallist.length).zip(finallist)
  val generatedpairs  = generatecorrectpairs(finallistzipped,finallist.vector)
  val answer          = generatedpairs.samesum
  println("The answer to advent of code 2017 day 1, part 2 is: " ++ answer.show)
//////////////////
