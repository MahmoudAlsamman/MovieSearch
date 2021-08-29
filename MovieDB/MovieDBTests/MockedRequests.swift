//
//  MockedRequests.swift
//  MovieDBTests
//
//  Created by Mahmoud Alsamman on 8/29/21.
//

import Foundation
@testable import MovieDB

struct SampleRequest: APIRequest {

    typealias Response = SampleResponse

    var testProperty1: String
    var testProperty2: String

    enum CodingKeys: String, CodingKey {
        case testProperty1
        case testProperty2
    }

    var method: APIRequestMethod {
        .get
    }

    var path: String {
        "/test"
    }

    /// An array of query items for the URL in the order in which they appear in the original query string.
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "query1", value: "value1")]
    }
}

struct SampleResponse: APIResponse {

    var testProperty: String

    enum CodingKeys: String, CodingKey {
        case testProperty
    }

    /// - SeeAlso: Swift.Decodable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        testProperty = try container.decode(String.self, forKey: .testProperty)
    }
}
