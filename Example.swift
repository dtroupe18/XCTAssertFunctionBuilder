import Foundation
import XCTest

@_functionBuilder
class BooleanFunctionBuilder {
  static func buildBlock(_ children: Bool...) -> [Bool] {
    return children
  }
}

public func assertTrue(@BooleanFunctionBuilder builder: () -> [Bool]) {
  let expressions = builder()
  expressions.forEach { XCTAssertTrue($0) }
}

public func assertFalse(@BooleanFunctionBuilder builder: () -> [Bool]) {
  let expressions = builder()
  expressions.forEach { XCTAssertFalse($0) }
}

// Example Usage

public class TestClass: XCTestCase {
  let a = 3
  let b = 4
  let c = 5

  func testValues() {
    assertTrue {
      a * a + b * b == c * c
      a == 3
      b == 4
      c == 5
    }

    assertFalse {
      a + b == c
      a + b < c
    }
  }
}

// Playground
TestClass.defaultTestSuite.run()
