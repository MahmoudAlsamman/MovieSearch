//
//  ResponsesDataTests.swift
//  MovieDBTests
//
//  Created by Mahmoud Alsamman on 8/29/21.
//

import XCTest
@testable import MovieDB

class ResponsesDataTests: XCTestCase {

    let jsonResponse = """
        [
            {
                "id": 689797,
                "overview": "Movie overview.",
                "poster_path": "/5X9Rhw0DTQCjtCUm4Aff4ssWYLZ.jpg",
                "release_date": "2013-02-19",
                "title": "Movie Name"
            },
            {
                "id": 606615,
                "overview": "Swayam takes Amarja's help to impress his crush but instead falls in love with her. Things take a turn when the couple decide to get married after Amarja is diagnosed with a deadly disease.",
                "poster_path": "/5X9Rhw0DTQCjtCUm4Aff4ssWYLZ.jpg",
                "release_date": "2019-02-14",
                "title": "Ashi Hi Aashiqui"
            }
        ]
        """

    func testMovieSearchResponse() {
        testDecodingResponse(
            fromJson: jsonResponse,
            type: [Movie].self
        )
    }
}

private extension ResponsesDataTests {

    @discardableResult func testDecodingResponse<T>(fromJson json: String, type: T.Type) -> T? where T: Decodable {
        do {
            if let data = json.data(using: .utf8) {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                jsonDecoder.dateDecodingStrategy = .iso8601
                let model = try jsonDecoder.decode(type, from: data)
                return model
            }
        } catch {
            XCTFail("Failed to parse response: \(error)")
        }
        return nil
    }
}
