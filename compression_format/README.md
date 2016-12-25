# CompressionFormat

Advent of Code 2016 Day 9 in Elixir

## To Execute

`iex -S mix`
`CompressionFormat.solve`

## Notes

```
> str
"(3x3)XYZ(1x3)"

> Regex.split(~r{\(.*?\)},str,include_captures: true)
["", "(3x3)", "XYZ", "(1x3)", ""]

[first, instruction | rest ] = Regex.split(~r{\(.*?\)},str,include_captures: true)
["ABC", "(3x3)", "XYZ", "(1x3)", "P"]
iex(25)> first
"ABC"
iex(26)> instruction
"(3x3)"
iex(27)> rest
["XYZ", "(1x3)", "P"]
iex(28)> Enum.join(rest)
"XYZ(1x3)P"
iex(29)> Enum.join(rest) |> String.split_at(3)
{"XYZ", "(1x3)P"}

# take first part and repeat it however many times, add to result
# repeat the process with the second part.
```

OR...
```
> str
"ABC(3x3)XYZ(1x3)PBY(2x4)"

> Regex.split(~r{\(.*?\)},str,include_captures: true, parts: 2)
["ABC", "(3x3)", "XYZ(1x3)PBY(2x4)"]
```

splits string into two parts around the first occurrence of something like (2x4)
now we have first, pattern, rest where first gets added to the result
and pattern is applied to rest, without having to join it back together

Regex is:
\( - escaped literal open paren
.  - any character
*  - any number of preceding pattern
?  - lazy / non-greedy, stops after the first match
\) - escaped literal close paren
