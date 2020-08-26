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
    var info: Dictionary<String, Any>? {
        // 属性观察器
        // 属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外
        
        // 注意: 在父类初始化方法调用之后，在子类构造器中给父类的属性赋值时，会调用父类属性的 willSet 和 didSet 观察器。而在父类初始化方法调用之前，给子类的属性赋值时不会调用子类属性的观察器
        
        // 在新的值被设置之前调用
        willSet {
            print("new value %@", newValue ?? Dictionary<String,Any>.self)
        }
        // didSet 在新的值被设置之后调用
        didSet {
            print("-- %@", info ?? Dictionary<String,Any>.self)
        }
    }
    var level: Level? = .unknow
    
}
