import wisp
import mist
import jellyfin/router
import jellyfin/web
import gleam/erlang/process

pub fn main() {
  wisp.configure_logger()

  let secret_key_base = wisp.random_string(64)

  let ctx = web.create_context()

  let handler = router.handle_request(_, ctx)

  let assert Ok(_) =
    wisp.mist_handler(handler, secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http
  process.sleep_forever()
}
