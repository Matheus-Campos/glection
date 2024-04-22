import web/context.{type Context}
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, _context: Context) -> Response {
  case wisp.path_segments(req) {
    [] -> wisp.ok()
    _ -> wisp.not_found()
  }
}
