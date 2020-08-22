//
//  Base.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/21.
//

import Foundation

class Base: UIViewController {
    
    // 与其他大部分编程语言不同，Swift 并不强制要求你在每条语句的结尾处使用分号（;），当然，你也可以按照你自己的习惯添加分号。有一种情况下必须要用分号，即你打算在同一行内写多条独立的语句
    override func viewDidLoad() {
        let cat = "🐱"; print(cat)
        
        // Int
        /**
         Swift 也提供了一个特殊的无符号类型 UInt，长度与当前平台的原生字长相同
         在32位平台上，UInt 和 UInt32 长度相同。
         在64位平台上，UInt 和 UInt64 长度相同
         
         注意：
         尽量不要使用 UInt，除非你真的需要存储一个和当前平台原生字长相同的无符号整数。除了这种情况，最好使用 Int，即使你要存储的值已知是非负的。统一使用 Int 可以提高代码的可复用性，避免不同类型数字之间的转换
         */
        
        // Swift 提供了两种有符号浮点数类型：
        /**
         Double 表示64位浮点数。当你需要存储很大或者很高精度的浮点数时请使用此类型。
         Float 表示32位浮点数。精度要求不高的话可以使用此类型
         
         注意：
         Double 精确度很高，至少有15位数字，而 Float 只有6位数字。选择哪个类型取决于你的代码需要处理的值的范围，在两种类型都匹配的情况下，将优先选择 Double
         */
        
        
        // 数值型字面量
        /**
         整数字面量可以被写作：

         一个十进制数，没有前缀
         一个二进制数，前缀是 0b
         一个八进制数，前缀是 0o
         一个十六进制数，前缀是 0x
         */
        
        let decimalInteger = 17       // 十进制17
        let binaryInteger = 0b10001   // 二进制17
        let octalInteger = 0o21       // 八进制17
        let hexadecimalInteger = 0x11 // 十六进制17
        
        print("decimalInteger:\(decimalInteger) + binaryInteger:\(binaryInteger) + octalInteger:\(octalInteger) + hexadecimalInteger:\(hexadecimalInteger)")
        
        
        // 浮点字面量
        /**
         浮点字面量可以是十进制（没有前缀）或者是十六进制（前缀是 0x ）。小数点两边必须有至少一个十进制数字（或者是十六进制的数字）。十进制浮点数也可以有一个可选的指数（exponent)，通过大写或者小写的 e 来指定；十六进制浮点数必须有一个指数，通过大写或者小写的 p 来指定
         
         如果一个十进制数的指数为 exp，那这个数相当于基数和10^exp 的乘积
         1.25e2 表示 1.25 × 10^2，等于 125.0。
         1.25e-2 表示 1.25 × 10^-2，等于 0.0125
         
         如果一个十六进制数的指数为 exp，那这个数相当于基数和2^exp 的乘积：
         0xFp2 表示 15 × 2^2，等于 60.0。
         0xFp-2 表示 15 × 2^-2，等于 3.75
         */
        // 下面的这些浮点字面量都等于十进制的 12.1875
        let decimalDouble = 12.1875     // 十进制
        let exponentDouble = 1.21875e1  // 指数
        let hexadecimalDouble = 0xC.3p0 // 十六进制
        
        print("decimalDouble:\(decimalDouble) + exponentDouble:\(exponentDouble) + hexadecimalDouble:\(hexadecimalDouble)")
        
        
        // 证书转换
        /**
         不同整数类型的变量和常量可以存储不同范围的数字。Int8 类型的常量或者变量可以存储的数字范围是 -128~127，而 UInt8 类型的常量或者变量能存储的数字范围是 0~255。如果数字超出了常量或者变量可存储的范围，编译的时候会报错
         */
        // let cannotBeNegative: UInt8 = -1
        // UInt8 类型不能存储负数，所以会报错
        
        // let tooBig: Int8 = Int8.max + 1
        // Int8 类型不能存储超过最大值的数，所以会报错
        
        
        // 元组 tuples
        // 元组（tuples）把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型
        // http404Error 的类型是 (Int, String)，值是 (404, "Not Found")
        // 这个元组可以被描述为“一个类型为 (Int, String) 的元组”
        let http404Error = (404, "Not Found")
        
        // 如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记
        let (justTheStatusCode, _) = http404Error
        
        // 你还可以通过下标来访问元组中的单个元素，下标从零开始
        print("The status code is \(http404Error.0)")
        print("The status message is \(http404Error.1)")
        
        
        let http200Status = (statusCode: 200, description: "OK")
        // 给元组中的元素命名后，你可以通过名字来获取这些元素的值
        print("The status code is \(http200Status.statusCode)")
        print("The status message is \(http200Status.description)")
        
        
        /// 可选类型
        // 使用可选类型（optionals）来处理值可能缺失的情况。可选类型表示两种可能： 或者有值， 你可以解析可选类型访问这个值， 或者根本没有值
        /**
         C 和 Objective-C 中并没有可选类型这个概念。最接近的是 Objective-C 中的一个特性，一个方法要不返回一个对象要不返回 nil，nil 表示“缺少一个合法的对象”。然而，这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。对于这些类型，Objective-C 方法一般会返回一个特殊值（比如 NSNotFound）来暗示值缺失。这种方法假设方法的调用者知道并记得对特殊值进行判断。然而，Swift 的可选类型可以让你暗示任意类型的值缺失，并不需要一个特殊值
         
         nil 不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型
         
         当你确定可选类型确实包含值之后，你可以在可选的名字后面加一个感叹号（!）来获取值，这被称为可选值的强制解析（forced unwrapping）
         */
                
        // 错误处理
        // 当一个函数遇到错误条件，它能报错。调用函数的地方能抛出错误消息并合理处理
        func canThrowAnError() throws {
            // 这个函数可能抛出错误
        }
        
        // 一个函数可以通过在声明中添加 throws 关键词来抛出错误消息。当你的函数能抛出错误消息时，你应该在表达式中前置 try 关键词
        // 一个 do 语句创建了一个新的包含作用域，使得错误能被传播到一个或多个 catch 从句
        do {
            try canThrowAnError()
            // 没有错误消息抛出
        } catch {
            // 有一个错误消息抛出
        }
        
        handleMake()
        handleAssert()
    }
}

extension Base {
    
    enum MyError: Error {
        case beyound
        case less
    }
    
    func makeASandwich() throws {
        let data = [2,5,8,9,6,3]
        
        for i in data {
            guard i < 8 else {
                throw MyError.beyound
            }
            guard i > 3 else {
                throw MyError.less
            }
        }
    }
    
    
    // 因为 makeASandwich() 抛出错误，函数调用被包裹在 try 表达式中。将函数包裹在一个 do 语句中，任何被抛出的错误会被传播到提供的 catch 从句中
    // 值得注意的是,在可能抛出异常的方法中,一但有一处抛出了一个异常,那么这个方法则会立刻停止运行.抛出异常代码后面的代码都将不会得到执行
    func handleMake()  {
        do {
            try makeASandwich()
        } catch {
            switch error {
            case MyError.beyound:
                print("超出了")
            case MyError.less:
                print("不足")
            default:
                print("符合条件")
            }
        }
    }
    
    func handleAssert()  {
        let age = 3
        let index = 2
        
        // 使用断言进行调试，向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示
        assert(age >= 0, "A person's age cannot be less than zero")
        
        
        // 强制执行先决条件
        // 当一个条件可能为假，但是继续执行代码要求条件必须为真的时候，需要使用先决条件
        precondition(index > 0, "Index must be greater than zero.")
        
        
        /**
         注意

         如果你使用 unchecked 模式（-Ounchecked）编译代码，先决条件将不会进行检查。编译器假设所有的先决条件总是为 true（真），他将优化你的代码。然而，fatalError(_:file:line:) 函数总是中断执行，无论你怎么进行优化设定。

         你能使用 fatalError(_:file:line:) 函数在设计原型和早期开发阶段，这个阶段只有方法的声明，但是没有具体实现，你可以在方法体中写上 fatalError("Unimplemented")作为具体实现。因为 fatalError 不会像断言和先决条件那样被优化掉，所以你可以确保当代码执行到一个没有被实现的方法时，程序会被中断。
         */
        
        /**
         
         assert和precondition的区别
         
         precondition 和 assert 的格式类似，也是动态的，precondition 会造成程序的提前终止并抛出错误信息
         Precondition在一般的代码中并不多见，因为它是动态的，只会在程序运行时进行检查，适用于哪些无法在编译期间确定的风险情况。

         如果出现了诸如数据错误的情况，Precondition会提前终止程序，避免因数据错误造成更多的损失。
         如果条件判断为True ,代码运行会继续进行。
         如果条件判断为false,程序将终止。
         assert是单纯地触发断言即停止程序，不会让你有机会将可能出错的设计走过它那一关。
         */
        
    }
    
}
