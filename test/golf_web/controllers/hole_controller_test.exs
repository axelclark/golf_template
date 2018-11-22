defmodule GolfWeb.HoleControllerTest do
  use GolfWeb.ConnCase

  alias Golf.Scorecard

  @create_attrs %{hole_number: 42, par: 42}
  @update_attrs %{hole_number: 43, par: 43}
  @invalid_attrs %{hole_number: nil, par: nil}

  def fixture(:hole) do
    {:ok, hole} = Scorecard.create_hole(@create_attrs)
    hole
  end

  describe "index" do
    test "lists all holes", %{conn: conn} do
      conn = get(conn, Routes.hole_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Holes"
    end
  end

  describe "new hole" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.hole_path(conn, :new))
      assert html_response(conn, 200) =~ "New Hole"
    end
  end

  describe "create hole" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.hole_path(conn, :create), hole: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.hole_path(conn, :show, id)

      conn = get(conn, Routes.hole_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Hole"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.hole_path(conn, :create), hole: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hole"
    end
  end

  describe "edit hole" do
    setup [:create_hole]

    test "renders form for editing chosen hole", %{conn: conn, hole: hole} do
      conn = get(conn, Routes.hole_path(conn, :edit, hole))
      assert html_response(conn, 200) =~ "Edit Hole"
    end
  end

  describe "update hole" do
    setup [:create_hole]

    test "redirects when data is valid", %{conn: conn, hole: hole} do
      conn = put(conn, Routes.hole_path(conn, :update, hole), hole: @update_attrs)
      assert redirected_to(conn) == Routes.hole_path(conn, :show, hole)

      conn = get(conn, Routes.hole_path(conn, :show, hole))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, hole: hole} do
      conn = put(conn, Routes.hole_path(conn, :update, hole), hole: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Hole"
    end
  end

  describe "delete hole" do
    setup [:create_hole]

    test "deletes chosen hole", %{conn: conn, hole: hole} do
      conn = delete(conn, Routes.hole_path(conn, :delete, hole))
      assert redirected_to(conn) == Routes.hole_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.hole_path(conn, :show, hole))
      end
    end
  end

  defp create_hole(_) do
    hole = fixture(:hole)
    {:ok, hole: hole}
  end
end
