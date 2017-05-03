// The MIT License (MIT)
//
// Copyright (c) 2017 zqqf16
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import XCTest
@testable import ThemeEngine

class ThemeEngineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data: Dictionary<String, Any> = [
            "a": ["a": "a", "bg": "red"],
            "b": ["b": "b", "bg": "blue"],
            "a b": ["a b": "a b", "bg": "yellow"],
        ]
        
        let engine = Engine()
        engine.theme = Parser.parse(data: data)
        
        let style = engine.style(names: ["a", "b"])
        
        XCTAssertEqual(style["bg"], "blue")
        XCTAssertEqual(style["b"], "b")
        XCTAssertEqual(style["a b"], "a b")
        XCTAssertEqual(style["a"], "a")
        
        let style2 = engine.style(names: ["a"])
        XCTAssertEqual(style2["a"], "a")
        XCTAssertEqual(style2["bg"], "red")
        XCTAssertNil(style2["b"])
        XCTAssertNil(style2["a b"])
        
        let style3 = engine.style(names: ["b"])
        XCTAssertEqual(style3["b"], "b")
        XCTAssertEqual(style3["bg"], "blue")
        XCTAssertNil(style3["a"])
        XCTAssertNil(style2["a b"])
    }

    func dataFromFile(name: String) -> Dictionary<String, Any> {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: name, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        
        return json as! Dictionary<String, Any>
    }
    
    func testParser() {
        // This is an example of a performance test case.
        
        let json = dataFromFile(name: "theme1")
        self.measure {
            // Put the code you want to measure the time of here.
            let _ = Parser.parse(data: json)
        }
    }
    
    func testMatching() {
        let json = dataFromFile(name: "theme1")
        let engine = Engine()
        engine.theme = Parser.parse(data: json)

        self.measure {
            let _ = engine.style(names: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n"])
        }
    }
    
}
