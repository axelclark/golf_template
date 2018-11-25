defmodule GolfWeb.RoundControllerTest do
  use GolfWeb.ConnCase

  alias Golf.Scorecard

  @create_attrs %{started_on: ~D[2010-04-17]}
  @update_attrs %{started_on: ~D[2011-05-18]}
  @invalid_attrs %{started_on: nil}

  def fixture(:round) do
    {:ok, round} = Scorecard.create_round(@create_attrs)
    round
  end

  describe "index" do
    test "lists all rounds", %{conn: conn} do
      conn = get(conn, Routes.round_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rounds"
    end
  end

  describe "new round" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.round_path(conn, :new))
      assert html_response(conn, 200) =~ "New Round"
    end
  end

  describe "create round" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.round_path(conn, :create), round: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.round_path(conn, :show, id)

      conn = get(conn, Routes.round_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Round"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.round_path(conn, :create), round: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Round"
    end
  end

  describe "edit round" do
    setup [:create_round]

    test "renders form for editing chosen round", %{conn: conn, round: round} do
      conn = get(conn, Routes.round_path(conn, :edit, round))
      assert html_response(conn, 200) =~ "Edit Round"
    end
  end

  describe "update round" do
    setup [:create_round]

    test "redirects when data is valid", %{conn: conn, round: round} do
      conn = put(conn, Routes.round_path(conn, :update, round), round: @update_attrs)
      assert redirected_to(conn) == Routes.round_path(conn, :show, round)

      conn = get(conn, Routes.round_path(conn, :show, round))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, round: round} do
      conn = put(conn, Routes.round_path(conn, :update, round), round: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Round"
    end
  end

  describe "delete round" do
    setup [:create_round]

    test "deletes chosen round", %{conn: conn, round: round} do
      conn = delete(conn, Routes.round_path(conn, :delete, round))
      assert redirected_to(conn) == Routes.round_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.round_path(conn, :show, round))
      end
    end
  end

  defp create_round(_) do
    round = fixture(:round)
    {:ok, round: round}
  end
end