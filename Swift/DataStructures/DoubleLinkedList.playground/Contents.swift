import UIKit

// MARK: - LinkedList (Lista ligada)

class Node {
    var value: String
    var nextNode: Node?
    weak var previousNode: Node?
    
    init(value: String) {
        self.value = value
    }
}

class DoubleLinkedList {
    private var head: Node? // First element
    private var tail: Node? // Last element
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        return tail
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    public func append(value: String) {
        let newNode = Node(value: value)
        
        if let oldtailNode = tail {
            newNode.previousNode = oldtailNode
            oldtailNode.nextNode = newNode
        } else {  // tail don't exist
            head = newNode
        }
        
        tail = newNode
    }
    
    public func nodeAt(index: Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            
            while node != nil {
                if i == 0 { return node }
                
                i -= 1
                node = node!.nextNode
            }
        }
        return nil
    }
    
    public func remove(node: Node) {
        let prevNode = node.previousNode
        let nextNode = node.nextNode
        
        if let prevNode {
            prevNode.nextNode = nextNode  // the next node of the previous node will be the next node of the current node. What we're doing is replacing the current to the next node of it.
        } else {
            head = nextNode
        }
        
        // Updating previous pointer to the next node
        nextNode?.previousNode = prevNode
        
        if nextNode == nil {  // if we're removing the tail
            tail = prevNode
        }
        
        // remove node removed references
        node.previousNode = nil
        node.nextNode = nil
    }
}

extension DoubleLinkedList: CustomStringConvertible {
    var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.nextNode
            if node != nil { text += ", " }
        }
        return text + "]"
    }
}

var linkedList = DoubleLinkedList()
linkedList.isEmpty

linkedList.append(value: "firstValue")
linkedList.append(value: "secondValue")
linkedList.first
linkedList.nodeAt(index: 1)
linkedList.nodeAt(index: 2)
linkedList.nodeAt(index: -1)
linkedList.append(value: "thirdNode")

if let firstNode = linkedList.nodeAt(index: 0) {
    linkedList.remove(node: firstNode)
}
linkedList.description
