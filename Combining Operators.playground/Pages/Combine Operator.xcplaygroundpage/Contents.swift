//: [Previous](@previous)

import Foundation
import Combine


//MARK: - Merge Operator
/// Merge different events into one publisher
/// They need to be of the same type

//let publisherONE = PassthroughSubject<Int, Never>()
//let publisherTWO = PassthroughSubject<Int, Never>()
//
//publisherONE.merge(with: publisherTWO ).sink{
//    print($0)
//}
//
//publisherONE.send(10)
//publisherTWO.send(20)

let numbers = [10,2,2,4,6,6,8].publisher

/// If the values do not satisy this condition then there will be no emitters
numbers.allSatisfy { $0 % 2 == 0}
    .sink{ allEven in
        print(allEven)
    }
