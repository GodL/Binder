import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BinderTests.allTests),
        testcase(FilterTests.allTests),
    ]
}
#endif
