//
//  File.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/24.
//

import Foundation


// 属性包装器
/**
 属性包装器在管理属性如何存储和定义属性的代码之间添加了一个分隔层
 定义一个属性包装器，你需要创建一个定义 wrappedValue 属性的结构体、枚举或者类
 
 属性包装器在管理属性如何存储和定义属性的代码之间添加了一个分隔层。举例来说，如果你的属性需要线程安全性检查或者需要在数据库中存储它们的基本数据，那么必须给每个属性添加同样的逻辑代码。当使用属性包装器时，你只需在定义属性包装器时编写一次管理代码，然后应用到多个属性上来进行复用
 
 */


/**
 定义一个属性包装器，你需要创建一个定义 wrappedValue 属性的结构体、枚举或者类。在下面的代码中，TwelveOrLess 结构体确保它包装的值始终是小于等于 12 的数字。如果要求它存储一个更大的数字，它则会存储 12 这个数字
 
 注意：示例以 private 的方式声明 number 变量，这使得 number 仅在 TwelveOrLess 的实现中使用。写在其他地方的代码通过使用 wrappedValue 的 getter 和 setter 来获取这个值，但不能直接使用 number
 */
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get {
            return number
            
        }
        set {
            number = min(newValue, 12)
            
        }
    }
}

// 把一个包装器应用到一个属性上，编译器将合成提供包装器存储空间和通过包装器访问属性的代码。（属性包装器只负责存储被包装值，所以没有合成这些代码）
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

// 写法第二个版本：将其属性明确地包装在 TwelveOrLess 结构体中，而不是把 @TwelveOrLess 作为特性写下来
struct SmallRectangle2 {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get {
            return _height.wrappedValue
        }
        set {
            _height.wrappedValue = newValue
        }
    }
    var width: Int {
        get {
            return _width.wrappedValue
        }
        set {
            _width.wrappedValue = newValue
        }
    }
}

class Wrapper {
    var TotalSteps: Int = 0 {
        
        // 属性观察器 属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外
        // 注意 在父类初始化方法调用之后，在子类构造器中给父类的属性赋值时，会调用父类属性的 willSet 和 didSet 观察器。而在父类初始化方法调用之前，给子类的属性赋值时不会调用子类属性的观察器
        
        // willSet 在新的值被设置之前调用 newValue
        willSet(newTotalSteps) {
            print("new total steps - > %@", newTotalSteps)
        }
        // didSet 在新的值被设置之后调用 oldValue
        didSet {
            if TotalSteps > oldValue {
                print("add value -> \(TotalSteps - oldValue)")
            }
        }
    }
    
    init() {
        
        let rectangle = SmallRectangle()
        print("\(rectangle.width)")
        
        var narrowRectangle = NarrowRectangle()
        print(narrowRectangle.height, narrowRectangle.width)
        
        narrowRectangle.height = 100
        narrowRectangle.width = 100
        print(narrowRectangle.height, narrowRectangle.width)
    }
}


// 定义包括三个构造器——init()、init(wrappedValue:) 和 init(wrappedValue:maximum:)
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get {
            return number
        }
        set {
            number = min(newValue, maximum)
        }
    }
    
    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int ,maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 10) var width: Int
}


struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}


// MARK: -

// 从属性包装器中呈现一个值
/**
 除了被包装值，属性包装器可以通过定义被呈现值暴露出其他功能。举个例子，管理对数据库的访问的属性包装器可以在它的被呈现值上暴露出 flushDatabaseConnection() 方法。除了以货币符号（$）开头，被呈现值的名称和被包装值是一样的。因为你的代码不能够定义以 $ 开头的属性，所以被呈现值永远不会与你定义的属性有冲突
 
 写下 s.$someNumber 即可访问包装器的被呈现值，
 需要暴露出更多信息的包装器可以返回其他数据类型的实例，或者可以返回自身来暴露出包装器的实例，并把其作为它的被呈现值
 */
@propertyWrapper
struct SmallNumberWrapper {
    private var number = 0
    var projectedValue = false
    var wrappedValue: Int {
        get {
            return number
        }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            }
            else {
                number = newValue
                projectedValue = false
            }
        }
    }
}

struct SomeStructureX {
    @SmallNumberWrapper var someNumberX: Int
}

extension Wrapper {
    
    // 当包含属性包装器实参时，你也可以使用赋值来指定初始值。Swift 将赋值视为 wrappedValue 参数，且使用接受被包含的实参的构造器
    func mixRect()  {
        var mixedRectangle = MixedRectangle()
        print(mixedRectangle.height)
        
        mixedRectangle.height = 20
        print(mixedRectangle.height)
    }
    
    func structureX()  {
        // 属性包装器呈现一个值,写下 s.$someNumber 即可访问包装器的被呈现值
        var someStructureX = SomeStructureX()
        someStructureX.someNumberX = 4
        // 打印出false
        print(someStructureX.$someNumberX)

        someStructureX.someNumberX = 55
        // 打印出true
        print(someStructureX.$someNumberX)
    }
}

// MARK: -

 /**
 当从类型的一部分代码中访问被呈现值，例如属性 getter 或实例方法，你可以在属性名称之前省略 self.，就像访问其他属性一样。以下示例中的代码用 $height 和 $width 引用包装器 height 和 width 的被呈现值
 
 因为属性包装器语法只是具有 getter 和 setter 的属性的语法糖，所以访问 height 和 width 的行为与访问任何其他属性的行为相同
 
 语法糖（Syntactic sugar），也译为糖衣语法，指计算机语言中添加的某种语法，这种语法对语言的功能并没有影响，但是更方便程序员使用。通常来说使用语法糖能够增加程序的可读性，从而减少程序代码出错的机会。
 语法糖是编程语言为开发者提供的实现某个操作的更简便的方法
 */
enum Size {
    case small, large
}

struct SizedRectangle {
    @SmallNumberWrapper var height: Int
    @SmallNumberWrapper var width: Int
    
    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $width || $height
    }
}
