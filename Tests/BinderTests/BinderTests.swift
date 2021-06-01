import XCTest
import UIKit
@testable import Binder

final class BinderTests: XCTestCase {
    
    
    @Binding
    var items: [String] = []
    
    func testExample() {
        
        let tableView = UITableView()
        
        
       
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
