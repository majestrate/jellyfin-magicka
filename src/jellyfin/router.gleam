import wisp.{type Request, type Response}
import gleam/http.{Get, Post}
import gleam/string_builder
import jellyfin/web

pub fn handle_request(req: Request) -> Response {
  use req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> serve_index(req)
    _ -> wisp.not_found()
  }
}

fn serve_index(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("index page")
  wisp.ok()
  |> wisp.html_body(html)
}
