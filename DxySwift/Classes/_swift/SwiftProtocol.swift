//
//  SwiftProtocol.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/24.
//

/**
 协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议
 */
import Foundation

// 协议的定义方式与类、结构体和枚举的定义非常相似
protocol SomeProtocol {
    // 这里是协议的定义部分
}


// 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示
protocol FirstProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

// 在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性
protocol AnotherProtocol {

}

// 要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔
struct SomeStructure: FirstProtocol, AnotherProtocol {
    
    var mustBeSettable: Int
    var doesNotNeedToBeSettable: Int
    
    // 这里是结构体的定义部分
}
