defmodule TopflowWeb.UserControllerTest do
  use TopflowWeb.ConnCase, async: true
  alias Topflow.Users.User
  import Topflow.DataCase, only: [errors_on: 1]

  @moduletag :auth

  describe "Signup page -" do
    @describetag :signup

    setup %{conn: conn} do
      {:ok, conn: get(conn, "/registration/new")}
    end

    test("works", %{conn: conn}, do: assert(conn.status == 200))

    test "shows all the fields", %{conn: conn} do
      assert conn.resp_body =~ "Email"
      assert conn.resp_body =~ "Firstname"
      assert conn.resp_body =~ "Middlename"
      assert conn.resp_body =~ "Lastname"
      assert conn.resp_body =~ "Password"
      assert conn.resp_body =~ "Password confirmation"
    end
  end

  describe "Signup page - creating user -" do
    @describetag :signup

    setup %{conn: conn} do
      user = %{
        user: %{
          email: "angelo.moreira+test-post@gmail.com",
          password: "testing123",
          password_confirmation: "testing123",
          firstname: "Angelo Post",
          middlename: "Favery Post",
          lastname: "Moreira Post"
        }
      }

      assert %{assigns: %{current_user: user}} = post(conn, "/registration", user)

      {:ok, user: user}
    end

    test "successfully", %{user: user} do
      assert %User{id: user_id} = user
      assert is_integer(user_id)
    end

    test "role is correct", %{user: user} do
      assert %{role: "user"} = user
    end

    test "is unverified", %{user: user} do
      assert %{verified: false} = user
    end

    test "is not suspended", %{user: user} do
      assert %{suspended: false} = user
    end
  end

  describe "Signup page - error creating user -" do
    @describetag :signup

    setup %{conn: conn} do
      assert %{assigns: %{changeset: %{errors: errors_list}}} =
               post(conn, "/registration", %{user: %{email: "angelo.moreira"}})

      {:ok, errors: Map.new(errors_list)}
    end

    test "email is incorrect", %{errors: errors} do
      assert %{email: {_, validation}} = errors
      assert :email_format = Keyword.get(validation, :validation)
    end

    test "required fields not present", %{errors: errors} do
      assert %{firstname: {_reason, firstname}} = errors
      assert %{lastname: {_reason, lastname}} = errors
      assert %{password: {_reason, password}} = errors

      assert :required = Keyword.get(firstname, :validation)
      assert :required = Keyword.get(lastname, :validation)
      assert :required = Keyword.get(password, :validation)
    end
  end

  describe "Sign in page" do
    @describetag :signin

    setup %{conn: conn} do
      conn = get(conn, "/session/new")
      {:ok, conn: conn}
    end

    test "returns correct status code", %{conn: conn} do
      assert conn.status == 200
    end

    test "shows email password", %{conn: conn} do
      assert conn.resp_body =~ "Email"
      assert conn.resp_body =~ "Password"
    end
  end

  @tag :signin
  test "login successfully", %{conn: conn} do
    user_credentials = %{email: "angelo.moreira+test1@gmail.com", password: "testing123"}
    res = post(conn, "/session", %{user: user_credentials})

    assert %{status: 302} = res
    assert %{assigns: %{current_user: user}} = res
    assert is_integer(user.id)
  end

  @tag :signin
  test "login error", %{conn: conn} do
    user_credentials = %{email: "angelo.moreira+test1@gmail.com", password: "this_is_wrong_dude"}
    res = post(conn, "/session", %{user: user_credentials})

    assert %{status: 200} = res
    assert %{assigns: %{changeset: %{valid?: false}}} = res
  end
end
