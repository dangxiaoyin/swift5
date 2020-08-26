//
//  Subscript.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/24.
//

import Foundation

// 下标语法
/**
 下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行查询。它的语法类似于实例方法语法和计算型属性语法。定义下标使用 subscript 关键字，与定义实例方法类似，都是指定一个或多个输入参数和一个返回类型。与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，类似计算型属性
 */

// 示例:用来表示对应整数的乘法表
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

class Subscript: UIViewController {
    override func viewDidLoad() {
        // 创建了一个 TimesTable 实例，用来表示整数 3 的乘法表,数值 3 被传递给结构体的构造函数，作为实例成员 multiplier 的值
        let threeTimesTable = TimesTable(multiplier: 3)
        // 这条语句查询了乘法表中 3 的第六个元素
        print("six times three is \(threeTimesTable[6])")
        
        // TimesTable 例子基于一个固定的数学公式，对 threeTimesTable[someIndex] 进行赋值操作并不合适，因此下标定义为只读的。
    }
}

/**
 下标用法
 
 “下标”的确切含义取决于使用场景。下标通常作为访问集合，列表或序列中元素的快捷方式。你可以针对自己特定的类或结构体功能来以最恰当的方式实现下标
 
 例如，Swift 的 Dictionary 类型实现下标用于对实例中储存的值进行存取操作。为字典设值时，在下标中使用和字典的键类型相同的键，并把一个和字典的值类型相同的值赋给这个下标：
 */
