import wisp.{type Request, type Response}
import gleam/http.{Get}
import gleam/string_builder
import gleam/json
import jellyfin/web
import gleam/list
import gleam/result.{unwrap}

pub fn handle_request(req: Request, ctx: web.Context) -> Response {
  use req <- web.middleware(req, ctx)

  case wisp.path_segments(req) {
    [] -> serve_index(req)
    ["api", "v1", ..] -> route_api_v1(req)
    _ -> wisp.not_found()
  }
}

fn serve_index(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("index page")
  wisp.ok()
  |> wisp.html_body(html)
}

fn serve_api_v1_version(req: Request) -> Response {
  case req.method {
    Get ->
      wisp.ok()
      |> wisp.json_body(json.to_string_builder(web.version()))
    _ -> wisp.method_not_allowed(allowed: [Get])
  }
}

fn slice_off_api_prefix(path: List(a)) -> List(a) {
  // slice off the first two parts of the path
  path
  |> list.rest
  |> unwrap([])
  |> list.rest
  |> unwrap([])
}

fn route_api_v1(req: Request) -> Response {
  let path =
    wisp.path_segments(req)
    |> slice_off_api_prefix
  case path {
    ["version"] -> serve_api_v1_version(req)
    _ -> wisp.not_found()
  }
}
