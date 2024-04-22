import config
import gleam/erlang/process
import gleam/result.{try}
import mist
import mungo
import router
import web/context.{Context}
import wisp

pub fn main() {
  use app_config <- try(config.load())

  let assert Ok(client) = mungo.start(app_config.db_url, 30)

  wisp.configure_logger()

  let secret_key_base = wisp.random_string(256)

  let context = Context(db_conn: client)

  let _ =
    router.handle_request(_, context)
    |> wisp.mist_handler(secret_key_base)
    |> mist.new
    |> mist.port(app_config.port)
    |> mist.start_http

  Ok(process.sleep_forever())
}
