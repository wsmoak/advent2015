# Ipv7

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ipv7` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ipv7, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ipv7` is started before your application:

    ```elixir
    def application do
      [applications: [:ipv7]]
    end
    ```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ipv7](https://hexdocs.pm/ipv7).


# stuff inside square brackets
iex(22)> Regex.scan(~r"\[(.*?)\]", "abba[zzzz]abcde[yyyy]kkkk") |> Enum.map( fn([x,y]) -> y end)
=> ["zzzz", "yyyy"]

# stuff outside square brackets
iex(23)> Regex.split(~r"\[(.*?)\]", "abba[zzzz]abcde[yyyy]kkkk")
=> ["abba", "abcde", "kkkk"]
