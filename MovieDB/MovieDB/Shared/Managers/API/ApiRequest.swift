//
//  ApiRequest.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation

/// HTTP requets method.
public enum APIRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol APIRequest: Encodable {

    /// The type of a response.
    associatedtype Response: APIResponse

    var basePath: String { get }
    /// Path of the request. Will be resolved against base URL.
    var path: String { get }
    /// HTTP method of the request.
    var method: APIRequestMethod { get }
    /// An array of query items for the URL in the order in which they appear in the original query string.
    var queryItems: [URLQueryItem]? { get }

    func buildURL() -> URL
}

extension APIRequest {

    var basePath: String {
        "https://api.themoviedb.org/3"
    }

    var queryItems: [URLQueryItem]? { nil }

    public var debugDescription: String {
        let body: String = {
            guard let bodyData = try? JSONEncoder().encode(self) else { return "no body" }
            return String(data: bodyData, encoding: .utf8) ?? ""
        }()
        return """
            HTTP method: \(method.rawValue),\n
            Path: \(fullPath),\n
            Default HTTP headers: \(defaultHeaders) (extra headers excluded),\n
            Query items: \(String(describing: queryItems)),\n
            JSON body: \(body)\n
        """
    }
    
    func buildURL() -> URL {
        let baseURL = URL(string: fullPath)!
        var components = URLComponents()
        components.queryItems = queryItems
        return components.url(relativeTo: baseURL)!
    }
}

private extension APIRequest {

    var fullPath: String { basePath + path }

    var defaultHeaders: [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

 
}
