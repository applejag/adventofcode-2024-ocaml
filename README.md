# Advent of Code 2024 via OCalm

This repo contains my attempt at Advent of Code 2024 (<https://adventofcode.com/2024>)

> [!NOTE]
> I gave up on OCaml. In summary, what a horrible mess when trying to look
> at docs to learn how to use stuff. It's like when trying to use Emacs
> or NixOS for the first time, people online write "oh to get this thing
> working, just add this stanza to your moniker list, super simple" like
> WHAT ARE YOU TALKING ABOUT???
>
> I just wanted to use some Regex on [day 3](https://adventofcode.com/2024/day/3)
> but I've spent so much time digging through docs and StackOverflow
> answers to try understand how to just *get a damn regex working!*
>
> In summary: OCaml needs to work on their onboarding and improve their
> docs before I ever try that language again.
> For now, this endevour can die in hell while I'm going to skip over to
> a different language.

## Running

Requires regular install of OCaml (v5.2.1+) with `opam` (v2.3.0+)
and `dune` (v3.17.0+): <https://ocaml.org/install>

```console
$ dune exec adventofcode -- --help
adventofcode <day>
  --file Input file inside the inputs/dayXX/ directory
  -help  Display this list of options
  --help  Display this list of options
```

```console
$ dune exec adventofcode -- 1
=== file: inputs/day01/input.txt
=== day 01, part 1:
sum: 2430334

=== day 01, part 2:
array len: 99980
sum: 28786472
```
