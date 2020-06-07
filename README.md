# XCTAssertFunctionBuilder
Write XCTAssertTrue &amp;&amp; XCTAssertFalse less

Pulled this function builder from this great talk at [DotSwift](https://www.youtube.com/watch?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=email&utm_source=iOS%2BDev%2BWeekly%2BIssue%2B459&v=Or6xjaCUCd4).


## User function builder to pass multiple statements to `XCTAssertTrue` or `XCTAssertFalse`.

```swift
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
```

## Example Usage.

```swift

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

  // Run in a playground.
  
  TestClass.defaultTestSuite.run()
```
