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


class Node {
    let name: String
    
    typealias Style = Dictionary<String, String>

    var style: Style = Style()
    var parents: Dictionary<String, Node> = [:]
    
    init(name: String) {
        self.name = name
    }
    
    func merge(_ another: Node) {
        another.style.forEach { style.updateValue($1, forKey: $0) }
        another.parents.forEach { (name, node) in
            if let p = self.parents[name] {
                p.merge(node)
            } else {
                self.parents[name] = node
            }
        }
    }
    
    func updateStyle(_ another: Node.Style) {
        another.forEach { self.style.updateValue($1, forKey: $0) }
    }
}

extension Node {
    func findStyles(chain: [String]) -> [Style] {
        var styles: [Style] = []
        if self.style.count > 0 {
            styles.append(self.style)
        }
        
        let count = chain.count
        
        for (i, n) in chain.enumerated() {
            guard let parent = self.parents[n] else {
                continue
            }
            
            let newChain = Array(chain[i+1..<count])
            let parentStyles = parent.findStyles(chain: newChain)
            parentStyles.forEach {
                styles.append($0)
            }
        }
        
        return styles
    }
}
