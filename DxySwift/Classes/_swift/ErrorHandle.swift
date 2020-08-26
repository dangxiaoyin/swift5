//
//  ErrorHandle.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/24.
//

import Foundation

/**
 错误处理（Error handling） 是响应错误以及从错误中恢复的过程。Swift 在运行时提供了抛出、捕获、传递和操作可恢复错误（recoverable errors）的一等支持（first-class support）
 
 在 Swift 中，错误用遵循 Error 协议的类型的值来表示。这个空协议表明该类型可以用于错误处理
 */

enum VendingMachineError: Error {
    case invalidSelection // 选择无效
    case insufficientFunds(coinsNeeded: Int) // 金额不足
    case outOfStock // 缺货
}


/**
 注意

 Swift 中的错误处理和其他语言中用 try，catch 和 throw 进行异常处理很像。和其他语言中（包括 Objective-C ）的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw 语句的性能特性是可以和 return 语句相媲美的
 */
class ErrorHandle: UIViewController {
    override func viewDidLoad() {
        
        // do-catch语句
        do {
            let x = try canThrowErrors()
            print("\(x)")
        } catch  {
            print(error)
        }
    }
    
    // 一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域
    // 注意： 只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理
    func canThrowErrors() throws -> String {
        throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
    }
    
    func cannotThrowErrors() -> String {
        return ""
    }
}


// MARK: -

struct Item {
    var price: Int
    var count: Int
}


class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    
    var item = Item(price: 20, count: 10)

    func vend(itemNamed name: String) throws {
        guard inventory[name] != nil  else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price < 10 else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price)
        }
        
    }
    
    // 用 Do-Catch 处理错误
    // 你可以使用一个 do-catch 语句运行一段闭包代码来处理错误。如果在 do 子句中的代码抛出了一个错误，这个错误会与 catch 子句做匹配，从而决定哪条子句能处理它。
    
    func DoCatch() {
        
    }
}
