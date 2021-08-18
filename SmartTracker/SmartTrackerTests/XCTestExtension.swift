//
//  XCTestExtension.swift
//  XCTestExtension
//
//  Created by Harry Yan on 18/08/21.
//

import XCTest
import Combine

extension XCTestCase {
    func wait<T: Publisher>(
        for publisher: T,
        timeout: TimeInterval = 5,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")
        
        let cancellable = publisher.sink(
            receiveCompletion: { _ in
            },
            receiveValue: { value in
                result = .success(value)
                expectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        
        return try unwrappedResult.get()
    }
}
