
import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var param: String? { get }
    
}

extension Request {
    var asURLRequest: URLRequest {
        let apiKey = "&apikey=f3dd7969"
        let url = URL(string: baseUrl + path + param! + apiKey)!
        let request = URLRequest(url: url)
        return request
    }
}
//Purpose: The extension provides a default implementation for creating a URLRequest from the Request protocol properties. This means that any type conforming to Request can use this default implementation to create a URLRequest.
