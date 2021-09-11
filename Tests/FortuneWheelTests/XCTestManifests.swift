import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(FortuneWheelTests.allTests),
        ]
    }
#endif
