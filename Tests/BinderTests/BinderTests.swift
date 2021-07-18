import XCTest
import UIKit
@testable import Binder

final class BinderTests: XCTestCase {
    
    @Binding
    var age: Int = 0
    
    class Person: BindCompatible {
        var name: String = ""
        
        var age: Int = 1 {
            didSet {
                ageDidSetCount += 1
            }
        }
        
        var ageText: String = "" {
            didSet {
                ageDidSetCount += 1
            }
        }
        
        var ageDidSetCount: Int = 0
    }
    
    func testFilter() {
        let person = Person()
        $age.filter { age in
            age > 0 && age <= 18
        } ~> person.bind[\.age]
        age = -1
        XCTAssertEqual(person.age, 1)
        
        age = 10
        XCTAssertEqual(person.age, 10)
        
        age = 20
        XCTAssertEqual(person.age, 10)
    }
    
    func testMap() {
        let person = Person()
        
        $age.map {
            "\($0)"
        } ~> person.bind[\.ageText]
        
        age = 10
        XCTAssertEqual(person.ageText, "10")
    }
    
    func testDo() {
        let person = Person()
        
        $age.do { age in
            XCTAssertEqual(age, 10)
        } ~> person.bind[\.age]
        
        age = 10
        XCTAssertEqual(person.age, 10)
    }
    
    func testDelay() {
        let person = Person()
        
        $age.delay(.seconds(3)) ~> person.bind[\.age]
        
        age = 18
        
        XCTAssertEqual(person.age, 1)
        
        let expectation = self.expectation(description: "testDelay")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertEqual(person.age, 18)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testDistinctUntilChanged() {
        let person = Person()
        
        $age.distinctUntilChanged() ~> person.bind[\.age]
        age = 10
        age = 10
        age = 18
        age = 18
        XCTAssertEqual(person.age, 18)
        XCTAssertEqual(person.ageDidSetCount, 2)
    }
    
    func testMerge() {
        @Binding var age1: Int = 0
        
        @Binding var age2: Int = 0
        
        let person = Person()
        $age.merge($age1, $age2) ~> person.bind[\.age]
        
        age = 10
        XCTAssertEqual(person.age, 10)
        
        age1 = 11
        XCTAssertEqual(person.age, 11)
        
        age2 = 12
        XCTAssertEqual(person.age, 12)
    }
    
    func testSkip() {
        let person = Person()
        
        $age.skip(3) ~> person.bind[\.age]
        
        age = 10
        XCTAssertNotEqual(person.age, 10)
        age = 11
        XCTAssertNotEqual(person.age, 11)
        age = 12
        XCTAssertNotEqual(person.age, 12)
        age = 13
        
        XCTAssertEqual(person.age, 13)
    }
    
    func testTake() {
        let person = Person()
        $age.take(3) ~> person.bind[\.age]
        
        age = 10
        XCTAssertEqual(person.age, 10)
        age = 11
        XCTAssertEqual(person.age, 11)
        age = 12
        XCTAssertEqual(person.age, 12)
        age = 13
        XCTAssertNotEqual(person.age, 13)
        XCTAssertEqual(person.age, 12)
    }
    
    func testCombine() {
        let person = Person()
        
        $age.filter { age in
            return age >= 11
        }.map { age in
            return String(age)
        }.do { age in
            XCTAssertEqual(age, String(self.age))
        }.skip(2).take(10).distinctUntilChanged().delay(.seconds(3)) ~> person.bind[\.ageText]
        
        age = 10
        age = 11
        age = 14
        age = 15
        age = 18
        age = 18
        age = 19
        let expectation = self.expectation(description: "testCombine")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertEqual(person.ageText, "19")
            XCTAssertEqual(person.ageDidSetCount, 3)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 10)
        
    }
    
    static var allTests = [
        ("testFilter", testFilter),
        ("testMap", testMap),
        ("testDo", testDo),
        ("testDelay", testDelay),
        ("testMerge", testMerge),
        ("testSkip", testSkip),
        ("testTake", testTake),
        ("testCombine", testCombine),
    ]
}
