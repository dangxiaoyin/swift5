//
//  Base.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/21.
//
// https://beeth0ven.github.io/RxSwift-Chinese-Documentation/


import Foundation
import RxSwift
// RxSwift需配合RxCocoa依赖使用
import RxCocoa

/*
 
     为什么要使用RxSwift
 
     复合 - Rx 就是复合的代名词
     复用 - 因为它易复合
     清晰 - 因为声明都是不可变更的
     易用 - 因为它抽象的了异步编程，使我们统一了代码风格
     稳定 - 因为 Rx 是完全通过单元测试的
 
 */

class whyRxSwift: UIViewController {
    
    var button: UIButton?
    var scrollview: UIScrollView?
    var disposeBag = DisposeBag()
    var ntfObserver: NSObjectProtocol?

    override func viewDidLoad() {
        
    }
            
    deinit {
        NotificationCenter.default.removeObserver(ntfObserver!)
    }

}


extension whyRxSwift {
    
    // MARK: - Target Action
    func targetAction()  {
        // 传统的写法
        button?.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 通过Rx来实现,不需要使用 Target Action，这样使得代码逻辑清晰可见
        button?.rx.tap
            .subscribe(onNext: { () in
                print("on")
            })
            .disposed(by: disposeBag)
    }
    @objc func buttonTapped() {
        
    }
    
    // MARK: - 代理
    func delegate() {
        // 传统实现方法
        scrollview?.delegate = self
        
        // 通过Rx来实现，不需要书写代理的配置代码，就能获得想要的结果
        scrollview?.rx.contentOffset
            .subscribe(onNext: { (contentOffset) in
                
            })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - 闭包回调
    func closureCallback()  {
        
        // 传统实现方法
        let urlStr = NSURL(string: "")
        URLSession.shared.dataTask(with: URLRequest(url: urlStr! as URL)) { (data, response, error) in
            guard error == nil else {
                print("Data Task Error: \(error!)")
                return
            }
            guard let data = data else {
                print("Data Task Error: unknown")
                return
            }
            
            print("Data Task Success with data: \(data)")
            
        }.resume()
        
        
        // 通过Rx来实现
        URLSession.shared.rx.data(request: URLRequest(url: urlStr! as URL))
            .subscribe { (data) in
                print("Data Task Success with data : \(data)")
            } onError: { (error) in
                print("Data Task Error: \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - 通知
    func notify() {
        // 传统写法
        ntfObserver = NotificationCenter.default.addObserver(forName: .UIApplicationWillEnterForeground, object: nil, queue: nil, using: { (notification) in
            print("Application Will Enter Foreground")
        })
        
        // 通过Rx来实现，不需要去管理观察者的生命周期，这样你就有更多精力去关注业务逻辑
        NotificationCenter.default.rx
            .notification(.UIApplicationWillEnterForeground)
            .subscribe { (notification) in
                print("Application Will Enter Foreground")
            }
            .disposed(by: disposeBag)

    }
}


extension whyRxSwift: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("contentOffSet: \(scrollView.contentOffset)")
    }
}


// MARK: - 多个任务之间有依赖关系

struct UserInfo {
    var info: NSDictionary?
}

enum API {
    // 通过用户名和密码获取一个token
    static func token(username: String, password: String, success: (String) -> Void, failure: (Error) -> Void) {
        
    }
    // 通过token取得用户信息
    static func userinfo(token: String, success: (UserInfo) -> Void, failure: (Error) -> Void) {
        
    }
}

enum RxAPI {
    // 通过用户名和密码获取一个token，Observable 可观察的对象
    static func token(username: String, password: String) -> Observable<String> {
        let ret = ""
        
        // just() 方法通过传入一个默认值来初始化
        return Observable.just(ret)
    }
    
    // 通过token获取用户信息
    static func userInfo(token: String) -> Observable<UserInfo> {
        let info = UserInfo()
        return Observable.just(info)
    }
}

extension whyRxSwift {
    func getInfo()  {
        // 通过用户名和密码获取用户信息
        API.token(username: "beetnOven", password: "789456") { (token) in
            API.userinfo(token: token) { (userInfo) in
                print("获取用户信息成功: \(userInfo)")
            } failure: { (error) in
                print("获取用户信息失败: \(error)")
            }
        } failure: { (error) in
            print("获取用户信息时报: \(error)")
        }
        
        
        // 通过Rx来实现，这样你可以避免回调地狱，从而使得代码易读，易维护
        RxAPI.token(username: "beethOven", password: "789456")
            .flatMapLatest(RxAPI.userInfo(token:))
            .subscribe { (userInfo) in
                print("获取用户信息成功: \(userInfo)")
            } onError: { (error) in
                print("获取用户信息失败: \(error)")
            }
            .disposed(by: disposeBag)

    }
}

// MARK: - 等待多个并发任务完成后处理结果

/**
 需要将两个网络请求合并成一个，
 通过 Rx 来实现，这样你可用寥寥几行代码来完成相当复杂的异步操作
 */

struct Teacher {
    var info: String?
}

struct Comments {
    var info: String?
}

// 用 Rx 封装接口
enum concurrentAPI {
    
    // 取得老师的详细信息
    static func teacher(id: Int) -> Observable<Teacher> {
        let t = Teacher(info: "")
        return Observable.just(t)
    }
    
    // 取得老师的评论
    static func teacherComments(id: Int) -> Observable<Comments> {
        let c = Comments(info: "")
        return Observable.just(c)
    }
}

extension whyRxSwift {
    func concurrent () {
        // zip同时获取老师信息和评价
        Observable.zip(
            concurrentAPI.teacher(id: 10),
            concurrentAPI.teacher(id: 20))
            .subscribe(onNext: { (teacher, comment) in
                print("获取老师信息成功: \(teacher)")
                print("获取老师评价成功: \(comment)")
            }, onError: { error in
                print("获取老师信息或评价失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
