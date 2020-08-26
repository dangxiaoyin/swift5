//
//  Structure.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/24.
//


/// 类和结构体
/// 作为一般准则，优先使用结构体，因为它们更容易理解，仅在适当或必要时才使用类

/**
 一：Swift 中结构体和类有很多共同点。两者都可以：

     定义属性用于存储值
     定义方法用于提供功能
     定义下标操作用于通过下标语法访问它们的值
     定义构造器用于设置初始值
     通过扩展以增加默认实现之外的功能
     遵循协议以提供某种标准功能
 
 二：与结构体相比，类还有如下的附加功能
 
     继承允许一个类继承另一个类的特征
     类型转换允许在运行时检查和解释一个类实例的类型
     析构器允许一个类实例释放任何其所被分配的资源
     引用计数允许对一个类的多次引用
 
 三：类支持的附加功能是以增加复杂性为代价的。作为一般准则，优先使用结构体，因为它们更容易理解，仅在适当或必要时才使用类。实际上，这意味着你的大多数自定义数据类型都会是结构体和枚举
 
 */

import Foundation


/**
 结构体和类有着相似的定义方式。你通过 struct 关键字引入结构体，通过 class 关键字引入类，并将它们的具体定义放在一对大括号中
 */
struct Resolution {
    // 在这里定义结构体
    
    /**
     示例中定义了一个名为 Resolution 的结构体，用来描述基于像素的分辨率。这个结构体包含了名为 width 和 height 的两个存储属性。存储属性是与结构体或者类绑定的，并存储在其中的常量或变量。当这两个属性被初始化为整数 0 的时候，它们会被推断为 Int 类型
     */
    var width = 0
    var height = 0
}

class VideoMode {
    // 在这里定义类
    
    /**
     示例还定义了一个名为 VideoMode 的类，用来描述视频显示器的某个特定视频模式。这个类包含了四个可变的存储属性。第一个， resolution，被初始化为一个新的 Resolution 结构体的实例，属性类型被推断为 Resolution。新 VideoMode 实例同时还会初始化其它三个属性，它们分别是初始值为 false 的 interlaced（意为“非隔行视频”），初始值为 0.0 的 frameRate，以及值为可选 String 的 name。因为 name 是一个可选类型，它会被自动赋予一个默认值 nil，意为“没有 name 值”
     */
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// 枚举也遵循相同的行为准则
enum CompassPoint {
    case north,south,east,west
    mutating func turnNorth() {
        self = .north
    }
}

class Structure: UIViewController {
    
    
    override func viewDidLoad() {
        
        /**
         通过这种方式所创建的类或者结构体实例，其属性均会被初始化为默认值
         */
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        print("this width is \(someResolution.width)")
        print("this.width.is -> \(someVideoMode.resolution.width)")
        
        
        /// 结构体类型的成员逐一构造器
        // 所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中
        // 与结构体不同，类实例没有默认的成员逐一构造器
        let vga = Resolution(width: 640, height: 480)
        
        // 结构体和枚举是值类型,值类型是这样一种类型，当它被赋值给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝
        // Swift 中所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型的属性，在代码中传递的时候都会被复制。
        
        // 声明了一个名为 cinema 的变量，并将 hd 赋值给它
        // 因为 Resolution 是一个结构体，所以会先创建一个现有实例的副本，然后将副本赋值给 cinema 。尽管 hd 和 cinema 有着相同的宽（width）和高（height），但是在幕后它们是两个完全不同的实例
        var cinema = vga
        cinema.width = 2048
        
        print("cinema.width \(cinema.width)")
        print("vga.widht \(vga.width)")
        
        
        
        // 当 rememberedDirection 被赋予了 currentDirection 的值，实际上它被赋予的是值的一个拷贝。赋值过程结束后再修改 currentDirection 的值并不影响 rememberedDirection 所储存的原始值的拷贝
        var currentDirection = CompassPoint.west
        let rememberedDirection = currentDirection
        currentDirection.turnNorth()
        print("The current direction is \(currentDirection)")
        print("The remembered direction is \(rememberedDirection)")

        
        // 类是引用类型
        // 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，使用的是已存在实例的引用，而不是其拷贝
        let tenEight = VideoMode()
        tenEight.resolution = vga
        tenEight.interlaced = true
        tenEight.name = "1080i"
        tenEight.frameRate = 25.0
        
        let alsoTenEight = tenEight
        alsoTenEight.frameRate = 30.0
        // 因为类是引用类型，所以 tenEight 和 alsoTenEight 实际上引用的是同一个 VideoMode 实例
        print("The frameRate property of tenEighty is now \(tenEight.frameRate)")
    }
    
    // 析构器 (finalizer)，计算机语言中的析构函数，当一个对象在消亡的时候，由编译器自动调用
    deinit {
        
    }
    
    
    
}
