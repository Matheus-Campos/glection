import gleam/erlang/process.{type Subject}
import mungo/client.{type Message}

pub type Context {
  Context(db_conn: Subject(Message))
}
