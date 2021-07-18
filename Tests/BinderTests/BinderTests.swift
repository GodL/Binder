import XCTest
import UIKit
@testable import Binder

final class BinderTests: XCTestCase {
    
    @Binding
    var age: Int = 0
    
    struct Person {
        var name: String = ""
        
        var age: Int = 1
    }
    
    func testFilter() {
        var person = Person()
        
    }
    
    func testExample() {

        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
