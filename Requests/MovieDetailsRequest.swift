

import Foundation

typealias MovieDetailsResponse = MovieDetail

struct MovieDetailsRequest: Request {    
    typealias Response = MovieDetailsResponse
    
    let baseUrl: String = "https://www.omdbapi.com/"
    let path: String = "?i="
    let method: HTTPMethod = .GET
    let param: String?
    
    init(imbdId: String) {
        param = imbdId
    }
}
