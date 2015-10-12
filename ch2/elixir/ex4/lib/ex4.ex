defmodule Ex4 do
  def main(args) do
    prompts = [%{subject: "noun"}, %{ subject: "verb"}, %{subject: "adjective", prep: "an"}, %{subject: "adverb", prep: "an"}]
    args
    |> parse_args
    |> process(prompts)
  end

  def process([ex: 1], prompts) do
    gather_subjects(prompts)
    |> show_result
  end

  def process([ex: 2]) do
    quotes = [
      %{ name: "John Wayne", quote: "Reach for the sky pilgrim." },
      %{ name: "Obi-Wan Kinobi", quote: "These are not the droids you are looking for." },
      %{ name: "Patrick Henry", quote: "Give me liberty or give me death!" },
    ]

    printit = fn(name, qt) -> IO.puts name <> " says, \"" <> qt <> "\"" end
    for %{name: name, quote: qt} <- quotes, do: printit.(name, qt)
  end

  def process([]) do
    IO.puts "Please supply an argument for what step to run."
  end

  def gather_subjects(prompts) do
    Enum.map(prompts, fn(pair) -> prompt(pair) end )
  end

  def prompt(%{ prep: prep, subject: subject }) do
    IO.puts "Enter #{prep} #{subject}:"
    answer = IO.read(:line) |> String.rstrip
    { String.to_atom(subject), answer }
  end

  def prompt(missing_prep) do
    prompt Map.merge(missing_prep, %{prep: "a"})
  end

  def show_result([ noun: noun, verb: verb, adjective: adj, adverb: adv ]) do
    IO.puts "Do you #{verb} your #{adj} #{noun} #{adv}.  That's hillarious!"
  end

  def parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [ex: :integer])
    options
  end

end
