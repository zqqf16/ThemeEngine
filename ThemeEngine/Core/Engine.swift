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


import Foundation

class Engine {
    
    typealias Theme = Dictionary<String, Node>
    var theme = Theme()
    
    func style(names: [String]) -> Node.Style {
        var styles: [Node.Style] = []

        let chain = Array(names.reversed())
        for (index, name) in chain.enumerated() {
            guard let node = theme[name] else {
                continue
            }
        
            let parents = Array(chain[index+1..<chain.count])
            let style = node.findStyles(chain: parents)
            styles.append(contentsOf: style)
        }
        
        var result = Node.Style()
        for style in styles.reversed() {
            style.forEach {
                result.updateValue($1, forKey: $0)
            }
        }
        
        return result
    }
}
