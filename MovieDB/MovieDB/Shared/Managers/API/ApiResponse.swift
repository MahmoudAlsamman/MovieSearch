//
//  ApiResponse.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation

public protocol APIResponse: Decodable {

    /// A decoder to be used when decoding a response.
    static var decoder: JSONDecoder { get }
}

extension APIResponse {

    public static var decoder: JSONDecoder {
        JSONDecoder()
    }
}

extension String: APIResponse {}
