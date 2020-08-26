//
//  Shape.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/21.
//

import Foundation

class Shape {
    
    var name: String?

    /// 类和对象
    // 使用 init 来创建一个构造器
    init(name: String) {
        self.name = name
    }
    
    // 需要在对象释放之前进行一些清理工作，使用 deinit 创建一个析构函数
    deinit {
        
    }
    
    func simpleDescription() -> String {
        return "a shape class with name: \(self.name ?? "defalue name")"
    }
    
    /// 泛型
    // 在尖括号里写一个名字来创建一个泛型函数或者类型
    func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]()
        
        for _ in 0..<numberOfTimes {
            result.append(item)
        }
        return result
    }
    
    
}
