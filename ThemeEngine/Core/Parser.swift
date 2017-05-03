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


extension String {
    func nodeNameChain() -> [String] {
        // "a b c" -> [c, b, a]
        return self.components(separatedBy: " ").reversed()
    }
}


struct Parser {
    
    typealias NodeRoot = Dictionary<String, Node>
    
    static func parse(data:Dictionary<String, Any>) -> NodeRoot {
        var root: NodeRoot = NodeRoot()
        data.forEach { (key, value) in
            guard let style = value as? Node.Style else {
                return
            }
            
            let names = key.nodeNameChain()

            let node = self.node(names: names, style: style)
            if let old = root[node.name] {
                old.merge(node)
            } else {
                root[node.name] = node
            }
        }
        
        return root
    }
    
    fileprivate static func node(names: [String], style:Node.Style) -> Node {
        let node = Node(name: names[0])
        if names.count == 1 {
            node.updateStyle(style)
            return node
        }
        
        let parentNames = Array(names[1..<names.count])
        let parent = self.node(names: parentNames, style: style)
        
        node.parents[parent.name] = parent
        return node
    }
}
