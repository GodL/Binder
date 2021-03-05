import XCTest
import UIKit
@testable import BinderNew
final class BinderTests: XCTestCase {
    
    @Binding
    var age: Int = 0
    
    @Default
    var a: String? = "dada"
    
    @Default
    var b: Int?
    
    func testExample() {
        
        let label = UILabel()
        
        
        
        $age.filter { $0 >= 0 }.map { String($0) } ~> label.bindTitle()
        
        age = 12
        
        age = -1
        XCTAssertEqual("12", label.text)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
