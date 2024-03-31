import gleeunit
import gleeunit/should
import jellyfin/router
import jellyfin/web
import jellyfin
import wisp/testing
import gleam/json
import gleam/bit_array

pub fn main() {
  gleeunit.main()
}

fn with_context(testcase: fn(web.Context) -> t) -> t {
  // Create the context to use in tests
  let context = web.Context(webui_directory: jellyfin.webui_directory())

  // Run the test with the context
  testcase(context)
}

pub fn api_v1_bogus_not_found_test() {
  use ctx <- with_context
  let request = testing.get("/api/v1/bogus", [])
  let response = router.handle_request(request, ctx)

  response.status
  |> should.equal(404)
}

pub fn api_v1_version_test() {
  use ctx <- with_context
  let request = testing.get("/api/v1/version", [])
  let response = router.handle_request(request, ctx)

  response.status
  |> should.equal(200)

  let assert Ok(body) =
    response
    |> testing.bit_array_body
    |> bit_array.to_string

  let expected =
    web.version()
    |> json.to_string()

  body
  |> should.equal(expected)
}
