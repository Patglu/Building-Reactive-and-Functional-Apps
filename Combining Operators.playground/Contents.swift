import UIKit
import Combine

///Appening values before the intials values

let numbers = (1...5).publisher
let secondNumebrs = (200...205).publisher

numbers.prepend(100,101)
    .prepend(-1,-2)
    .prepend([45,67])
    .prepend(secondNumebrs)
    .sink {
    print($0)
}
