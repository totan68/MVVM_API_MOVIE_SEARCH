
import Foundation

typealias MovieResponse = MovieArray

struct MoviesRequest: Request {
    typealias Response = MovieResponse
    
    let baseUrl: String = "https://www.omdbapi.com/"
    let path: String = "?s="
    let method: HTTPMethod = .GET
    let param: String?

    init(search: String) {
        param = search
    }
}
//designed to configure and handle network requests to fetch movie data from an API
