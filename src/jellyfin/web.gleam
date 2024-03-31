import wisp
import gleam/json

pub type Context {
  Context(webui_directory: String)
}

pub fn middleware(
  req: wisp.Request,
  ctx: Context,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)
  use <- wisp.serve_static(req, under: "/web", from: ctx.webui_directory)
  handle_request(req)
}

const version_string = "0.0.1"

pub fn version() -> json.Json {
  json.object([#("version", json.string(version_string))])
}

pub fn create_context() -> Context {
  Context(webui_directory: webui_directory())
}

fn webui_directory() -> String {
  let assert Ok(priv_directory) = wisp.priv_directory("jellyfin")
  priv_directory <> "/web"
}
