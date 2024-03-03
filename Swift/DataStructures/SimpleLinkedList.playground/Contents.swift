import UIKit

// MARK: - LinkedList (Lista ligada)

class Node {  // element - making it a class because struct can't have a recursive variable - can't point to anothe struct with same type
    var value: String
    var nextNode: Node?
    
    init(value: String) {
        self.value = value
    }
}

class SimpleLinkedList {
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
    
    public func append(value: String) {
        let newNode = Node(value: value)
        
        if let oldTailNode = tail {
            oldTailNode.nextNode = newNode  // next node of the old tail is the new node we're appending to be the new tail
            print(tail)
        } else {  // tail don't exist:
            head = newNode
        }
        
        // Tail is the last node added
        tail = newNode
    }
    
    public func nodeAt(index: Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            
            while node != nil {
                // i == 0, so we want to access the current node
                if i == 0 { return node }
                
                i -= 1
                node = node!.nextNode  // skip to the next node
            }
        }
        return nil
    }
    
    public func removeAll() {  // as the head and tail hold the other elements, if we nil both, we're removing all the elements of the linked list
        head = nil
        tail = nil
    }
    
    public func remove(node: Node) {
        // aux var to access the current and previous nodes
        var current = self.head
        var previous: Node? = nil
        
        while current != nil {
            if current?.value == node.value {  // found the node to remove
                if previous != nil {  // (it's not the head node) the current node is in the midle or the tail of the linked list
                    if current?.value == self.tail?.value {  //it's the tail
                        self.tail = previous // replace the current tail to the previous node (removing the node - previous tail)
                    }
                    
                    // atualiza o ponteiro 'próximo' do nó anterior (now is the tail)
                    previous?.nextNode = current?.nextNode  // if it's the tail, it'll be nil
                    // but if the node we're removing is in the midle of the linked list, then we're replacing it to the next node, skiping.
                    break
                } else {  // previous is nil, so we're removing the head
                    if current?.value == self.tail?.value {  // in case it's an 1 element linked list
                        self.tail = previous  // nil
                    }
                    
                    self.head = current?.nextNode  // updating replacing the head to the nextNode
                    break
                }
            }
        }
    }
    
}

extension SimpleLinkedList: CustomStringConvertible {
    public var description: String {
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

let linkedList = SimpleLinkedList()

linkedList.isEmpty
linkedList.append(value: "firstNode")
linkedList.description
linkedList.append(value: "secondNode")
linkedList.first?.value  // head
linkedList.last?.value  // tail
linkedList.nodeAt(index: 0)?.value
linkedList.nodeAt(index: 1)?.value
linkedList.last?.value
linkedList.append(value: "thirdNode")
linkedList.nodeAt(index: 1)?.nextNode?.value
linkedList.nodeAt(index: 1)?.nextNode?.nextNode
linkedList.nodeAt(index: 1)?.nextNode?.value
linkedList.remove(node: Node(value: "firstNode"))
linkedList.description
linkedList.removeAll()
linkedList.description
