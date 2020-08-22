//
//  Model.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/21.
//

import Foundation

/// 枚举外部可以直接调用
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six,seven, eight, nine, ten
    case jack, queen, king
}

public class StudentModel: NSObject {
    
    // class内枚举，外部调用时：StudentModel.Level
    enum Level: Int {
        case unknow = 0
        case optimal
        case middle
        case poor
    }
    
    // getter 和 setter 的计算属性
    // getter && setter 仅用于演示，日常开发中不用
    private var _name: String?
    
    var name: String? {
        /*
        get {
            // 返回 _成员变量
            return _name
        }
        set {
            // 使用 _成员变量记录值
            // setter 中，新值的名字是 newValue
            _name = newValue
            print(newValue!)
        }
         */
        
        // didset不可以与getter一起使用
        didSet {
            
            // 处理变量的可选值时，你可以在操作（比如方法、属性和子脚本）之前加 ?
            // 如果 ? 之前的值是 nil，? 后面的东西都会被忽略，并且整个表达式返回 nil
            print("student.name didset: \(name ?? "")")
        }
    }
    var age: Int?
    var hasComputer: Bool = false
    var info: Dictionary<String, Any>?
    var level: Level? = .unknow
    
}
