//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Raul.Lermen on 21/01/20.
//  Copyright © 2020 db1. All rights reserved.
//

import XCTest
import Hippolyte
@testable import Networking

class NetworkingTests: XCTestCase {

    struct TestBodyResponse: Codable, Hashable {
        let id: Int
        let name: String
    }

    struct TestEndpoint: Endpoint {

        public var baseURL: URL {
            return URL(string: "http://www.apple.com")!
        }

        public var path: String {
            return "iphone"
        }

        public var method: Networking.Method {
            return .get
        }

        public var headers: Headers? {
            return Headers().default
        }

        public var task: Task {
            return .requestPlain
        }
    }

    var networkProvider: NetworkProvider!
    var endpoint: TestEndpoint!
    var urlEndpoint: URL {
        let someUrl = URL(string: "www.google.com.br")!
        do {
            let urlRequest = try endpoint.urlRequest()
            return urlRequest.url ?? someUrl
        } catch {
            return someUrl
        }
    }

    override func setUp() {
        networkProvider = NetworkProvider()
        endpoint = TestEndpoint()
    }

    override func tearDown() {
        Hippolyte.shared.stop()
        super.tearDown()
    }

    func testRequestSuccess() {

        var stub = StubRequest(method: .GET, url: urlEndpoint)
        var response = StubResponse(statusCode: 200)
        let body = "STRING_BODY".data(using: .utf8)!
        response.body = body
        stub.response = response

        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()

        let expectation = self.expectation(description: "Stubs network call")
        networkProvider.request(endpoint) { (result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.data, body)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    func testRequestFailureStatus() {
        
        let errorCode = 500
        var stub = StubRequest(method: .GET, url: urlEndpoint)
        let response = StubResponse(statusCode: errorCode)
        stub.response = response

        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()

        let expectation = self.expectation(description: "Stubs network call")
        networkProvider.request(endpoint) { (result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, errorCode)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    func testRequestCodableSuccess() {
        
        let testObject = TestBodyResponse(id: 0, name: "")
        var stub = StubRequest(method: .GET, url: urlEndpoint)
        var response = StubResponse()
        let body = testObject.toJSON()!.data(using: .utf8)!
        response.body = body
        stub.response = response

        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()

        let expectation = self.expectation(description: "Stubs network call")
        networkProvider.requestDecodable(endpoint) { (result: Result<TestBodyResponse, NetworkError>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response, testObject)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testRequestCodableFail() {
        
        var stub = StubRequest(method: .GET, url: urlEndpoint)
        var response = StubResponse()
        let body = "ANY_TEXT".data(using: .utf8)!
        response.body = body
        stub.response = response

        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()

        let expectation = self.expectation(description: "Stubs network call")
        networkProvider.requestDecodable(endpoint) { (result: Result<TestBodyResponse, NetworkError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssert(true)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1)
    }

}
