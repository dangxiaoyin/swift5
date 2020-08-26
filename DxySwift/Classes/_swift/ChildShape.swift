//
//  ChildShape.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/21.
//

import Foundation

class ChildShape: Shape {
    var student: StudentModel!
    
    func perimeter() {
        student = StudentModel()
        student.name = "张三"
        student.age = 20
        student.hasComputer = true
        student.info = ["key1": "A", "key2": "B"]
        student.level = .optimal
        print("log : \(student.level ?? .unknow) + level: \(student.level?.rawValue ?? 0)")
        
        
        // 使用 init?(rawValue:) 初始化构造器来从原始值创建一个枚举实例。
        // 如果存在与原始值相应的枚举成员就返回该枚举成员，否则就返回 nil
        if let rank = Rank(rawValue: 9) {
            print(rank)
        }
        
        if let level = StudentModel.Level(rawValue: 1) {
            print(level)
        }
    }
    
}

