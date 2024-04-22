import dot_env
import dot_env/env
import gleam/int
import gleam/result.{try}

pub type AppConfig {
  AppConfig(db_url: String, port: Int)
}

pub fn load() -> Result(AppConfig, Nil) {
  dot_env.load()

  use db_url <- try(get_db_url())
  use port <- try(get_port())

  Ok(AppConfig(db_url: db_url, port: port))
}

fn get_db_url() -> Result(String, Nil) {
  env.get("DB_URL")
  |> result.nil_error
}

fn get_port() -> Result(Int, Nil) {
  let get_port =
    env.get("PORT")
    |> result.nil_error

  use port <- try(get_port)

  int.parse(port)
}
