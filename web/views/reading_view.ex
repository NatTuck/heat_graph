defmodule HeatGraph.ReadingView do
  use HeatGraph.Web, :view

  def render("create.json", _foo) do
    %{status: "OK"}
  end

  def render("error.json", %{errors: errs}) do
    %{status: "Error", errors: errs }
  end
end
