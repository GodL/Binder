import XCTest
import UIKit
@testable import Binder

final class BinderTests: XCTestCase {
    
    
    @Binding
    var startWith: String  = "123"
    
    func testExample() {
        
        let label = UILabel()
        
    
        
        XCTAssertEqual(label.text, "123")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
