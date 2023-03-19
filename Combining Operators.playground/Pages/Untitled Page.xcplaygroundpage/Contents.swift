import UIKit
import Combine

//MARK: - Prepend
///Appening values before the intials values

//let numbers = (1...5).publisher
//let secondNumebrs = (200...205).publisher
//
//numbers.prepend(100,101)
//    .prepend(-1,-2)
//    .prepend([45,67])
//    .prepend(secondNumebrs)
//    .sink {
//    print($0)
//}

//MARK: - Append
//let numbers = (1...10).publisher
//numbers.append(11,12)
//    .append(14,14)
//    .sink {
//        print($0)
//    }

//MARK: - Switch to latest
/// allows us to switch publihsers ot the latest one

//let publisheOne = PassthroughSubject<String, Never>()
//let publisherTwo = PassthroughSubject<String, Never>()
//
//let parentPublishers = PassthroughSubject<PassthroughSubject<String,Never>,Never>()
//
//parentPublishers
//    .switchToLatest()
//    .sink {
//        print($0)
//    }
///// We have subscribed the parent publisher to publisher ones changes
//parentPublishers.send(publisheOne)
//
//publisheOne.send("Value one")
//publisheOne.send("Value two")
//
///// It will now listent o publisher 2 changes
///// But once switched it stays on the second publisher
//parentPublishers.send(publisherTwo)
//publisherTwo.send("Value 1")

//MARK: - Switch to latest example
///Allows you to get informtation when the publisher switches to the latest time based on the time it takes to get called

let images = ["face1","face2","face3"]
let taps  = PassthroughSubject<Void,Never>()
var index = 0

/// Simulate network call
func getImage() -> AnyPublisher<String?, Never>{

    ///Returns a value immediatly and evaluates the body
    return Future<String?,Never> { promise in
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0){
            promise(.success(images[index]))
        }
    }.map{$0} /// we're mapping it as we are returning an array of publishers
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher() /// we can send it without knowing the publisher
}

let subs = taps.map{_ in getImage()}
    .switchToLatest()
    .sink {
        print($0)
    }

taps.send() /// Send will fire the subscription

DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
    index += 1
    taps.send()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 6.0){
    index += 1
    taps.send()
}

