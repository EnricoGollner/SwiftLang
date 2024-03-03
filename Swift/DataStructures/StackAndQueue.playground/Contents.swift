import UIKit

// MARK: - Stack (Pilha)
//* push() - Insere um elemento na última posição da pilha
//* pop() - Retira um elemento da última posição da pilha (LIFO)
//* top() - Observa o último elemento da pilha
struct StringStack { // pilha
    private var array: [String] = [String]()
    
    mutating func push(item: String) {
        array.append(item)
    }
    
    mutating func pop() -> String? {
        return array.popLast()
    }
    
    mutating func top() -> String? {
        return array.last
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
}

var stack = StringStack()
print(stack.isEmpty)

stack.push(item: "firstItem")
print(stack.isEmpty)

print(stack.top() ?? "Pilha vazia")

stack.push(item: "secondItem")
print(stack.top() ?? "Pilha Vazia")

stack.pop()
print(stack.top() ?? "Pilha Vazia")
stack.pop()
print(stack.top() ?? "Pilha Vazia")

print(stack.isEmpty)


//MARK: - Queue (Fila)
//* enqueue() - Insere um elemento na fila
//* dequeue() - Retira um elemento da fila
//* peek() - Observa o primeiro elemento da fila
struct IntQueue {
    private var items: [Int] = [Int]()
    
    mutating func enqueue(item: Int) {
        items.append(item)
    }
    
    mutating func dequeue() -> Int? {
        if items.isEmpty {
            return nil
        } else {
            let firstOut = items.first
            items.remove(at: 0)  // FIFO
            return firstOut
        }
    }
    
    mutating func peek()  -> Int?{
        return items.first
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
}

var queue = IntQueue()

queue.enqueue(item: 0)

let firstElement = queue.peek()
print(firstElement ?? "Fila vazia")

queue.enqueue(item: 2)
queue.enqueue(item: 3)

let dequeue = queue.dequeue() // FIFO
print(dequeue ?? "Fila vazia")

let secondDequeue = queue.dequeue()
print(secondDequeue ?? "Fila vazia")

queue.peek()  // 3

queue.isEmpty
queue.dequeue()
queue.isEmpty
