//
//  Grammar.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/20.
//
/**
 
 Swift 通过采用现代编程模式来避免大量常见编程错误
 
 变量始终在使用前初始化。
 检查数组索引超出范围的错误。
 检查整数是否溢出。
 可选值确保明确处理 nil 值。
 内存被自动管理。
 错误处理允许从意外故障控制恢复
 */


import Foundation


/// 语法
class Grammar: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        // 使用 let 来声明常量，使用 var 来声明变量
        // 个常量的值，在编译的时候，并不需要有明确的值，但是你只能为它赋值一次
        
        let label = " The width is "
        let width = 94
        
        // 值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换
        let widthLabel = label + String(width)
        print(widthLabel)
        
        // 有一种更简单的把值转换成字符串的方法：把值写到括号中，并且在括号之前写一个反斜杠（\）
        let widstr = "\(label) -> \(width)"
        print(widstr)
        
        
        // 使用方括号 [] 来创建数组和字典，并使用下标或者键（key）来访问元素。最后一个元素后面允许有个逗号
        var list = ["1", "2", "3", "4"]
        list.append("5")
        
        print(list)
        
        
        // 使用初始化语法来创建一个空数组或者空字典
        // let emptyArray = [String]()
        // let emptyDictionary = [String: Float]()
        
        // 如果类型信息可以被推断出来，你可以用 [] 和 [:] 来创建空数组和空字典——比如，在给变量赋新值或者给函数传参数的时候
        
        controlFlow()
        
        // class、 child class
        let shape = Shape.init(name: "Hello")
        let childShape = ChildShape(name: "Child")
        let shapeVal = shape.simpleDescription()
        print(shapeVal)
        
        childShape.perimeter()
    }
    
    deinit {
        
    }
    
    
}

/// 控制流
extension Grammar {
    // 使用 if 和 switch 来进行条件操作，使用 for-in、while 和 repeat-while 来进行循环。包裹条件和循环变量的括号可以省略，但是语句体的大括号是必须的
    private func controlFlow() {
        let individualScores = [75, 43, 103, 87];
        for score in individualScores {
            print(score)
        }
        
        // 使用 if 和 let 一起来处理值缺失的情况
        let optionalString: String? = "Hello"
        let optionalName: String? = "Apple"
        
        // 一个可选的值是一个具体的值或者是 nil 以表示值缺失。在类型后面加一个问号（?）来标记这个变量的值是可选的
        if let name = optionalName, let string = optionalString {
            print("\(string) + \(name)")
        }
        
        if let n = optionalName {
            print("\(String(describing: optionalString)) + \(n)")
        }
        
        // 另一种处理可选值的方法是通过使用 ?? 操作符来提供一个默认值。如果可选值缺失的话，可以使用默认值来代替
        print("\(optionalString ?? "defaultString") + \(optionalName ?? "defaultName")")
        
        
        
        // switch 支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log")
            
         case "cucumber", "watercress":
             print("That would make a good tea sandwich.")
        
            // 判断是否有后缀
            // let x where x.hasSuffix("pepper")
         case let x where x.hasSuffix("pepper"):
             print("Is it a spicy \(x)?")
            
        default:
            print("Everything tastes good in soup")
        }
        
        whileStatements()
        greet()
        
    }
    
    
    private func whileStatements() {
        // 使用 while 来重复运行一段代码直到条件改变。循环条件也可以在结尾，保证能至少循环一次
        var n = 2
        while n < 100 {
            n *= 2
            // print(n)
        }
        
        var m = 2
        repeat {
            m *= 2
            print(m)
        } while m < 100
        
        
        // 可以在循环中使用 ..< 来表示下标范围
        var total = 0
        // 0到3 不包含上限4
        for i in 0 ..< 4 {
            total += i
        }
                
    }
    
}


extension Grammar {
    /// 函数和闭包
    private func greet() {
        
        let val = callbackFunction(key: "oneDay:", param: "Tuesday")
        print(val)
        
        _ = callbackFunction2("1", "2")
        _ = callbackFunction3("1", on: "2")
        
        
        // 使用元组来生成复合值
        let val2 = calculateStatistics(scores: [1,2,3,4,5,6,7,8])
        print(val2.sum)
        
        // 函数作为返回值
        let increment = makeIncrementer()
        let val3 = increment(7)
        print("return func: \(val3)")
        
        
        // lessThanTen(number:)函数作为参数传递
        let numbers = [20,19,7,12]
        _ = hasAnyMatchs(list: numbers, condition: lessThanTen(number:))
        
        //
        closure()
        
    }
    
    // 使用 func 来声明一个函数，使用名字和参数来调用函数。使用 -> 来指定函数返回值的类型
    func callbackFunction(key: String, param: String) -> String {
        return key + param
    }
    
    // 默认情况下，函数使用它们的参数名称作为它们参数的标签，在参数名称前可以自定义参数标签，或者使用 _ 表示不使用参数标签
    func callbackFunction2(_ key: String, _ param: String) -> String {
        return key + param
    }
    
    func callbackFunction3(_ key: String, on param: String) -> String {
        return key + param
    }
    
    
    // 使用元组来生成复合值，比如让一个函数返回多个值。该元组的元素可以用名称或数字来获取
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            sum += score
        }
        return (min, max, sum)
    }
    
    
    // 函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函数
    func returnFifteen() -> Int {
        var y = 10
        // 嵌套函数
        func add() {
            y += 5
        }
        
        add()
        return y
    }
    
    // 函数是第一等类型，这意味着函数可以作为另一个函数的返回值
    func makeIncrementer() -> ((Int) -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        return addOne
    }
 
    // 函数也可以当做参数传入另一个函数
    func hasAnyMatchs(list: [Int], condition: (Int) -> Bool) -> Bool {
        for item in list {
            if condition(item) {
                return true
            }
        }
        return false
    }
    
    func lessThanTen(number: Int) -> Bool {
        return number < 10
    }
    
    // 函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包作用域中的变量和函数，即使闭包是在一个不同的作用域被执行的
    // 你可以使用 {} 来创建一个匿名闭包。使用 in 将参数和返回值类型的声明与闭包函数体进行分离
    
    func closure() {
        let numbers = [20,12,45,7]
        
        // map 方法返回的是一个数组，其获取一个闭包表达式作为唯一参数，集合中的每个元素调用一次该闭包函数，并返回该元素所映射的值(也可以是不同类型的值)。具体的映射方式和返回值类型由闭包来指定
        let ret = numbers.map { (number) -> Int in
            let ret = 3 * number
            return ret
        }
        print(ret)
        
        
        // 创建更简洁的闭包的方法
        let mapNumbers = numbers.map({number in 3 * number})
        print(mapNumbers)
        
    }
    
    
}
