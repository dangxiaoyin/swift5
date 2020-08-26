//
//  helloRxSwift.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/26.
//

import Foundation
import RxSwift
import RxCocoa

class helloRxSwift: UIViewController {
    
    var usernameOutlet: UITextField!
    var usernameValidOutlet: UILabel!
    var passwordOutlet: UITextField!
    var passwordValidOutlet: UILabel!
    var doSomethingOutlet: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        usernameOutlet = UITextField(frame: CGRect(x: 20, y: 60, width: 200, height: 30))
        usernameOutlet.backgroundColor = UIColor.lightGray
        view.addSubview(usernameOutlet)
        
        passwordOutlet = UITextField(frame: CGRect(x: 20, y: 100, width: 200, height: 30))
        passwordOutlet.backgroundColor = UIColor.lightGray
        view.addSubview(passwordOutlet)

        usernameValidOutlet = UILabel(frame: CGRect(x: 20, y: 140, width: 300, height: 30))
        usernameValidOutlet.backgroundColor = UIColor.yellow
        usernameValidOutlet.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(usernameValidOutlet)
        
        passwordValidOutlet = UILabel(frame: CGRect(x: 20, y: 180, width: 300, height: 30))
        passwordValidOutlet.backgroundColor = UIColor.yellow
        passwordValidOutlet.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(passwordValidOutlet)

        doSomethingOutlet = UIButton(type: .custom)
        doSomethingOutlet.frame = CGRect(x: 20, y: 220, width: 60, height: 30)
        doSomethingOutlet.backgroundColor = UIColor.red
        view.addSubview(doSomethingOutlet)
        
        
        
        let minimalUsernameLength = 5
        let minimalPasswordLength = 5
        
        /**
         当用户修改用户名输入框的内容时就会产生一个新的用户名, 然后通过 map 方法将它转化成用户名是否有效, 最后通过 bind(to: ...) 来决定密码输入框是否可用以及提示语是否隐藏
         */
        
        // 用户名是否有效
            let usernameValid = usernameOutlet.rx.text.orEmpty
                // 用户名 -> 用户名是否有效
                .map { $0.count >= minimalUsernameLength }
                .share(replay: 1)


            // 用户名是否有效 -> 密码输入框是否可用
            usernameValid
                .bind(to: passwordOutlet.rx.isEnabled)
                .disposed(by: disposeBag)

            // 用户名是否有效 -> 用户名提示语是否隐藏
            usernameValid
                .bind(to: usernameValidOutlet.rx.isHidden)
                .disposed(by: disposeBag)
        
        
        /*
         当密码输入不到 5 个字时显示提示文字
         这个和用用户名来控制提示语的逻辑是一样的
         */
        
        // 密码是否有效
            let passwordValid = passwordOutlet.rx.text.orEmpty
                // 密码 -> 密码是否有效
                .map { $0.count >= minimalPasswordLength }
                .share(replay: 1)


            // 密码是否有效 -> 密码提示语是否隐藏
            passwordValid
                .bind(to: passwordValidOutlet.rx.isHidden)
                .disposed(by: disposeBag)
        
        
        /*
         
         当用户名和密码都符合要求时，绿色按钮才可点击
         
         通过 Observable.combineLatest(...) { ... } 来将用户名是否有效以及密码是都有效合并出两者是否同时有效,然后用它来控制绿色按钮是否可点击
         */
        
        // 所有输入是否有效
            let everythingValid = Observable.combineLatest(
                  usernameValid,
                  passwordValid
                ) { $0 && $1 } // 取用户名和密码同时有效
                .share(replay: 1)


            // 所有输入是否有效 -> 绿色按钮是否可点击
            everythingValid
                .bind(to: doSomethingOutlet.rx.isEnabled)
                .disposed(by: disposeBag)
        
        
        /*
         点击绿色按钮后，弹出一个提示框
         */
        
        // 点击绿色按钮 -> 弹出提示框
            doSomethingOutlet.rx.tap
                .subscribe(onNext: { [weak self] in self?.showAlert() })
                .disposed(by: disposeBag)
    }
    
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )

        alertView.show()
    }
}


/*
 
 一：share(replay: 1) 是用来做什么的？

 我们用 usernameValid 来控制用户名提示语是否隐藏以及密码输入框是否可用。shareReplay 就是让他们共享这一个源，而不是为他们单独创建新的源。这样可以减少不必要的开支。

 二：disposed(by: disposeBag) 是用来做什么的？

 和我们所熟悉的对象一样，每一个绑定也是有生命周期的。并且这个绑定是可以被清除的。disposed(by: disposeBag)就是将绑定的生命周期交给 disposeBag 来管理。当 disposeBag 被释放的时候，那么里面尚未清除的绑定也就被清除了。这就相当于是在用 ARC 来管理绑定的生命周期
 
 */
