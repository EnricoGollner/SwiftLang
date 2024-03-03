import UIKit

//let startTime = CFAbsoluteTimeGetCurrent()  // Objeto padrão do SDK do iOS e retorna o tempo absoluto atual

//MARK: - DispatchQueue
//print(startTime)
//
//DispatchQueue.global().sync {  // Assíncrono
//    for i in 0...10 {
//        print("Fui... \(i)")
//    }
//}
//DispatchQueue.global().sync {
//    for i in 0...10 {
//        print("Voltei... - \(i)")
//    }
//}

// Caso precisarmos executar uma determinada atividade que vai demorar, que vai bloquear a main thread do aplicativo, executamos o DispatchQueue.global().sync

// Criando uma execução na main thread através do DispatchQueue:
// A DispatchQueue.main é uma fila serial globalmente disponível, que executa tarefas no encadeamento/thread principal do aplicativo.
//DispatchQueue.main.sync {
    // Executando na main thread
//}

//MARK: - Async/await
//func fetchUserId(from server: String) async -> Int {
//    return server == "primary" ? 97 : 501
//}
//
//func fetchUserName(from server: String) async -> String {
//    let userId = await fetchUserId(from: server)
//    
//    return userId == 501 ? "Enrico Gollner" : "Convidado"
//}
//
//func connectUser(to server: String) async {
//    //Utilizamos async para executar uma função assíncrona, permitindo que ela seja executada em paralelo:
//    //Ou seja, abaixo estamos executando 2 funções assíncronos em paralelo
//    async let userId = fetchUserId(from: server)
//    async let userName = fetchUserName(from: server)
//    
//    // Quando queremos utilizar o valor que ele retorna, utilizamos o "await":
//    let greeting = await "Hello, \(userName) with Id \(userId)"
//    print(greeting)
//}

// Para executar funções assíncronas de código síncrono, sem esperar que ela retorne.
// Do contrário teremos um erro.
//Task {
//    await connectUser(to: "primary")
//}

let gallery = [
    "Summer Vacation": ["praia.png", "campo.png", "zoo.png", "zoo.png"],
    "Road Trip": ["paris.png", "roma.png"]
]

func listPhotos(inGallery nameKey: String) async -> [String] {
    // Simulação de execução assíncrona:
    
    do {
        try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    } catch {}
    
    return gallery[nameKey] ?? []
}

func downloadPhoto(named: String) async -> Data {
    // Simulando chamada ao back-end
    do {
        try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    } catch {}
    return Data()
}

// Criando grupo de chamadas assíncronas:
// Simultaniedade estruturada:
Task {
    await withTaskGroup(of: Data.self) { taskGroup in
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        
        for photoName in photoNames {
            taskGroup.addTask {
                await downloadPhoto(named: photoName)
            }
        }
    }
}


// Simultaniedade não-estruturada:

//Swift suporta a simultaniedade não-estruturada, no qual temos total flexibilidade para gerenciar tarefas não estruturadas da maneira que o programa precisar.

// Para criar uma tarefa estruturada, que é executada no Actor atual, no ator atual, temos que executar o inicializador Task.init passando o parâmetro operation.
// Já para criarmos uma tarefa não-estruturada, que não faz parte do ator atual (conhecida como tarefa desanexada), chamamos o método *detach* da classe Task.

// Ambas as operações retornam uma tarefa com a qual podemos interagir.
Task {
    let photo = await listPhotos(inGallery: "Summer Vacation")[0]
    let handle = Task {
        return await downloadPhoto(named: photo)
    }
//    handle.cancel()
    let result = await handle.value
}

//Actors - Permitem que possamos compartilhar informações com segurança entre códigos simultaneos.
// Assim como as classes, os actors são reference types.
// Ao contrário das classes, os actors permitem que apenas uma tarefa acessem seu estado mutável por vez, o que torna seguro para o código, em várias tarefas, interagir com esse ator.
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

Task {
    let logger = TemperatureLogger(label: "Ar livre", measurement: 25)
    print(await logger.max)
}

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        
        if measurement > max {
            max = measurement
        }
    }
}

//
