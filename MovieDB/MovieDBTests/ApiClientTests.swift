//
//  ApiClientTests.swift
//  MovieDBTests
//
//  Created by Mahmoud Alsamman on 8/29/21.
//

import XCTest
import Foundation
@testable import MovieDB

class ApiClientTests: XCTestCase {

    var urlSessionMock: URLSessionMock!
    var sut: ApiClient!

    override func setUp() {
        super.setUp()
        urlSessionMock = URLSessionMock()
        sut = ApiClient(urlSession: urlSessionMock)
    }

    func testCallingRequests() {
        let request = SampleRequest(testProperty1: "1", testProperty2: "2")
        sut.perform(request: request) { _ in }

        guard let urlRequest = urlSessionMock.requestedUrl else {
            XCTFail("No request was called")
            return
        }
        XCTAssertEqual(urlRequest.absoluteString, "https://api.themoviedb.org/3/test?query1=value1")
    }

    func testSuccessAndParsing() {
        urlSessionMock.responseToSend = ResponseMock(statusCode: 200)
        urlSessionMock.dataToSend = "{\"testProperty\":\"test\"}".data(using: .utf8)
        let request = SampleRequest(testProperty1: "1", testProperty2: "2")
        let completionExpectation = expectation(description: "should complete")
        sut.perform(request: request) { result in
            switch result {
            case let .failure(error):
                print(error)
                XCTFail("Failed!")
            case let .success(response):
                XCTAssertEqual(response.testProperty, "test")
                completionExpectation.fulfill()
            }
        }
        wait(for: [completionExpectation], timeout: 1)
    }

    func testUnsuccessfulParsing() {
        urlSessionMock.responseToSend = ResponseMock(statusCode: 200)
        urlSessionMock.dataToSend = "{\"wrongName\":\"test\"}".data(using: .utf8)
        let request = SampleRequest(testProperty1: "1", testProperty2: "2")
        let completionExpectation = expectation(description: "Testing Async request.")
        sut.perform(request: request) { result in
            switch result {
            case let .failure(error):
                if error == .decoding {
                    completionExpectation.fulfill()
                } else {
                    XCTFail("Should return parsing error")
                }
            case .success:
                XCTFail("Should fail!")
            }
        }
        wait(for: [completionExpectation], timeout: 1)
    }
}
