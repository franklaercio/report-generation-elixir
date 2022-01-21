defmodule GenReport do
  alias GenReport.Parser

  # Daniele,7,29,4,2018

  @people [
    "cleiton",
    "daniele",
    "danilo",
    "diego",
    "giuliano",
    "jakeliny",
    "joseph",
    "mayk",
    "rafael",
    "vinicius"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  defp sum_values(
         [name, hours, _day, _month, _year],
         %{
           "all_hours" => all_hours
         } = report
       ) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    %{
      report
      | "all_hours" => all_hours
    }
  end

  def report_acc do
    all_hours = Enum.into(@people, %{}, &{String.downcase(&1), 0})

    %{
      "all_hours" => all_hours
    }
  end
end
