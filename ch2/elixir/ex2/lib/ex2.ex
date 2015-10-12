defmodule Ex2 do
  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([ex: 1]) do
    IO.puts "What is the input string?"
    name = IO.read(:line) |> String.rstrip
    IO.puts "#{name} has #{String.length name} characters."
  end

  def process([ex: 2]) do
    IO.puts "What is the input string?"
    IO.read(:line)
    |> String.rstrip
    |> output
  end

  def process([]) do
    IO.puts "Please supply an argument for what step to run."
  end

  def output("") do
    IO.puts "You must enter a non empty string."
  end

  def output(name) do
    IO.puts "#{name} has #{String.length name} characters."
  end

  def parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [ex: :integer])
    options
  end

end
