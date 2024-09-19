

import Foundation

final class APIClient {
    static let shared = APIClient()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private init () {}
    
    func send<T: Request>(_ request: T) async throws -> T.Response {
            let (data, _) = try await session.data(for: request.asURLRequest)
            return try decoder.decode(T.Response.self, from: data)
    }
}
//The APIClient class in my code is designed to handle network requests and responses in a Swift application. It provides a centralized way to perform HTTP operations and decode JSON responses into Swift models. 
