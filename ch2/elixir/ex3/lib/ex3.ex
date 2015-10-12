defmodule Ex3 do
  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([ex: 1]) do
    qt = prompt "What is the quote?"
    name = prompt "Who said it?"
    IO.puts name <> " says, \"" <> qt <> "\""
  end

  def process([ex: 2]) do
    quotes = [
      %{ name: "John Wayne", quote: "Reach for the sky pilgrim." },
      %{ name: "Obi-Wan Kinobi", quote: "These are not the droids you are looking for." },
      %{ name: "Patrick Henry", quote: "Give me liberty or give me death!" },
    ]

    print(quotes)
  end

  defp print([]) do
  end

  defp print([%{name: name, quote: quote} | tail]) do
    IO.puts name <> " says, \"" <> quote <> "\""
    print(tail)
  end

  def process([]) do
    IO.puts "Please supply an argument for what step to run."
  end

  def prompt(question) do
    IO.puts question
    IO.read(:line) |> String.rstrip
  end

  def parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [ex: :integer])
    options
  end

end
