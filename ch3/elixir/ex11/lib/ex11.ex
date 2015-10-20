defmodule Ex11 do
  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([ex: 1]) do
    ["How many euros are you exchanging? ", "What is the exchange rate? "]
    |> gather_input
    |> convert_numbers
    |> compute_result
    |> show_result
  end

  def process([ex: 2]) do
    #["How many euros are you exchanging? ", "What is the exchange rate? "]
    #|> gather_input
    #|> convert_numbers
    #|> compute_result
    #|> show_result
  end

  def process([ex: 3]) do
    rates_task = Task.async( fn -> get_rates end )

    [country_code, currency_ct] = ["What is the country code of your currency? ", "How much currency do you have? "] |> gather_input

    rates = Task.await(rates_task)

    exchange_rate = (1.0 / Map.get(rates,country_code)) * 100
    original_currency = convert_number(currency_ct)

    [ original_currency, exchange_rate]
    |> compute_result
    |> show_result(country_code)
  end

  def process([]) do
    IO.puts "Please supply an argument for what step to run."
  end

  def gather_input(prompts) do
    Enum.map(prompts, fn(question) -> prompt(question) end )
  end

  def convert_numbers(str_nums) do
    Enum.map(str_nums, fn(value) -> convert_number(value) end )
  end

  def convert_number(value) do
    { num, _other } = Float.parse(value)
    num
  end

  def prompt(question) do
    IO.gets(question) |> String.rstrip
  end

  def compute_result([euros, rate]) do
    %{ currency: euros, rate: rate, usd: Float.round((euros * rate) / 100.0, 2) }
  end

  def show_result(%{currency: euros, rate: rate, usd: usd}) do
    IO.puts "#{euros} euros at an exchange rate of #{rate} is #{usd} U.S. dollars."
  end

  def show_result(%{currency: val, rate: rate, usd: usd}, original_country) do
    IO.puts "#{val} in #{original_country} currency at an exchange rate of #{rate} is #{usd} U.S. dollars."
  end

  # Challenge 2 API
  def get_rates do
    url = "https://openexchangerates.org/api/latest.json?app_id=33acc4a9ebd54ddd8f49b083deddd434"
    %{ "rates" => rates} = get_url_response(url)
    rates
  end

  def get_url_response(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode! body
      _ ->
        nil
    end
  end

  def parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [ex: :integer])
    options
  end

end
