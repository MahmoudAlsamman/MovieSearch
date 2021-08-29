//
//  UrlSessionMock.swift
//  MovieDBTests
//
//  Created by Mahmoud Alsamman on 8/29/21.
//

import Foundation

class URLSessionMock: URLSession {

    var requestedUrl: URL?
    var dataToSend: Data?
    var responseToSend: ResponseMock?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        requestedUrl = url
        if let response = responseToSend {
            completionHandler(dataToSend, response, nil)
        }
        return URLSessionDataTaskMock()
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {

    override func resume() {}
}

class ResponseMock: HTTPURLResponse {

    init?(statusCode: Int) {
        super.init(
            url: URL(string: "https://www.google.com/")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
