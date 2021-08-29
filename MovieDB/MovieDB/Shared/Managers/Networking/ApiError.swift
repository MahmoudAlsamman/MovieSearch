//
//  ApiError.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation

enum APIClientError: Error, Equatable {
    case decoding
    case badHTTPResponse(statusCode: Int)
    case noDataRetrieved
    case HTTPResponse
    case invalidRequest
}
