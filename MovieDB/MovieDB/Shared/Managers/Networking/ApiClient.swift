//
//  ApiClient.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation

final class ApiClient {

    // MARK: - Properties

    private let urlSession: URLSession
    private (set) var apiKey: String = "73dc9a7cadd2b6d76b607a7f3fed304d"

    /// Initializes an instance.
    ///
    /// - Parameters:
    ///     - urlSession: URL session as a main interface for performing requests.
    init(
        urlSession: URLSession = .shared
    ) {
        self.urlSession = urlSession
    }
    
    /// Performs the API request and calls completion block with its response.
    /// - Parameters:
    ///   - request: The request to be performed.
    ///   - completion: The completion closure containing result of an operation.
    func perform<Request>(
        request: Request,
        completion: @escaping (Result<Request.Response, APIClientError>) -> Void
    ) where Request: APIRequest {
        
        /// Build a request url.
        let url = request.buildURL()
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            var finalResult: Result<Request.Response, APIClientError>

            if let _ = error {
                if AppScheme.logsEnabled { print("Error: \(APIClientError.HTTPResponse)") }
                finalResult = .failure(APIClientError.HTTPResponse)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                finalResult = .failure(APIClientError.HTTPResponse)
                if AppScheme.logsEnabled { print("Error: \(APIClientError.HTTPResponse)") }
                return
            }
            /// A range of acceptable status codes.
            let defaultAcceptableStatusCodes = 200...299
            guard defaultAcceptableStatusCodes.contains(httpResponse.statusCode) else {
                finalResult = .failure(APIClientError.badHTTPResponse(statusCode: httpResponse.statusCode))
                if AppScheme.logsEnabled { print("Error: \(APIClientError.badHTTPResponse(statusCode: httpResponse.statusCode))") }
                return
            }
            
            guard let data = data else {
                finalResult = .failure(APIClientError.noDataRetrieved)
                if AppScheme.logsEnabled { print("Error: \(APIClientError.noDataRetrieved)") }
                return
            }
            let jsonDecoder = Request.Response.decoder
            jsonDecoder.dateDecodingStrategy = .iso8601
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let result = try jsonDecoder.decode(Request.Response.self, from: data)
                finalResult = .success(result)
            }
            catch {
                finalResult = .failure(APIClientError.decoding)
                if AppScheme.logsEnabled { print("Error: \(APIClientError.decoding)") }
            }
            
            DispatchQueue.main.async {
                completion(finalResult)
            }
        }
        task.resume()
    }
}
