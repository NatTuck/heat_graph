ExUnit.start

Mix.Task.run "ecto.create", ~w(-r HeatGraph.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r HeatGraph.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(HeatGraph.Repo)

