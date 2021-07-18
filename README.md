# Binder

`Binder` is a data binding library driven by PropertyWrapper.

`Binder` implements a type-safe binding API. and some transform operator functions like `Rxswift`.
These operator functions can be combined with each other indefinitely.

## Operator

### Filter
like `Rxswift`'s filter
```swift
let person = Person()
$age.filter { age in
    age > 0 && age <= 18
} ~> person.bind[\.age]
age = -1
```

### Map
like `Rxswift`'s map
```swift
let person = Person()

$age.map {
    "\($0)"
} ~> person.bind[\.ageText]

age = 10
```

### Do
like `Rxswift`'s do
```swift
let person = Person()

$age.do { age in
    XCTAssertEqual(age, 10)
} ~> person.bind[\.age]

age = 10
```

### Merge
like `Rxswift`'s merge
```swift
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
```

### Skip
like `Rxswift`'s skip
```swift
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
```

### Take
like `Rxswift`'s take
```swift
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
```

### Delay
like `Rxswift`'s delay
```swift
let person = Person()

$age.delay(.seconds(3)) ~> person.bind[\.age]

age = 18

XCTAssertEqual(person.age, 1)

let expectation = self.expectation(description: "testDelay")
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    XCTAssertEqual(person.age, 18)
    expectation.fulfill()
}
```

### DistinctUntilChanged
like `Rxswift`'s distinctUntilChanged
```swift 
let person = Person()

$age.distinctUntilChanged() ~> person.bind[\.age]
age = 10
age = 10
age = 18
age = 18
XCTAssertEqual(person.age, 18)
XCTAssertEqual(person.ageDidSetCount, 2)
```

### Combine
Each combination
```swift
let person = Person()

$age.filter { age in
    return age >= 11
}.map { age in
    return String(age)
}.do { age in
    XCTAssertEqual(age, String(self.age))
}.skip(2).take(10).distinctUntilChanged().delay(.seconds(3)) ~> person.bind[\.ageText]
```

### UIKit
```swift
let label = UILabel()

$name ~> label.bind.text
```

## Installation
### Swift Package Manager
[Swift Package Manager](https://swift.org/package-manager/) is Apple's decentralized dependency manager to integrate libraries to your Swift projects. It is now fully integrated with Xcode 11

To integrate `ResponderChain` into your project using SPM, specify it in your `Package.swift` file:

```swift
let package = Package(
    …
    dependencies: [
        .package(url: "https://github.com/GodL/Binder.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "YourTarget", dependencies: ["Binder", …])
        …
    ]
)
```

## Author

GodL, 547188371@qq.com. Github [GodL](https://github.com/GodL)

*I am happy to answer any questions you may have. Just create a [new issue](https://github.com/GodL/Binder/issues/new).*

## License

MIT License

Copyright (c) 2021 GodL

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

