//
//  Mutating.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/24.
//


/// 在实例方法中修改值类型
import Foundation

/**
 结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改
 
 但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择 可变（mutating）行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
 
 要使用 可变方法，将关键字 mutating 放到方法的 func 关键字之前就可以了
 */

struct Point {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

class Mutating: UIViewController {
    
    override func viewDidLoad() {
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("this point is now at \(somePoint.x), \(somePoint.y)")
        
        /**
         上面的 Point 结构体定义了一个可变方法 moveBy（x：y :) 来移动 Point 实例到给定的位置。该方法被调用时修改了这个点，而不是返回一个新的点。方法定义时加上了 mutating 关键字，从而允许修改属性
         */
        
        // 注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性
        // 以下代码会报错
        // let fixedPoint = Point(x: 3.0, y: 3.0)
        // fixedPoint.moveBy(x: 2.0, y: 4.0)
        
        
        var ovenLight = TriStateSwitch.low
        ovenLight.next()
    }
    
}

/**
 示例：每次调用 next() 方法时，开关在不同的电源状态（off, low, high）之间循环切换
 */
enum TriStateSwitch {
    case off, low, high
    
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
        print(self)
    }
}
