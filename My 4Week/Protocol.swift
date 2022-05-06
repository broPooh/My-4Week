//
//  Protocol.swift
//  My 4Week
//
//  Created by bro on 2022/05/05.
//

import UIKit

//Protocol: 클래스, 구조체, 청사진..
//실질적인 구현은 하지 않는다!! // 명세만 담당.
//특정 뷰 객체에만 동작해야하는 경우도 많기 때문에 그때에도 많이 사용한다

//만약 프로토콜을 클래스에서만 사용하게 제한 -> : AnyObject를 추가해라
protocol OrderSystem: AnyObject {
    //프로토콜 메서드
    func recommanEventMenu()
    func askStampCard(count: Int) -> String
    
    //init()
    //초기화 구문 : 구조체가 멤버와이즈 구문이 있더라도 반드시 구현을 해주어야 한다.
    //클래스 같은 경우, 부모 클래스의 초기화 구문과 프로토콜의 초기화 구문을 구별해서 명시할수 있게 하기 위해서 required 를 붙이게 된다
}

class StarBucksMenu {
    
}

class Smoothie: StarBucksMenu, OrderSystem {
    func recommanEventMenu() {
        print("스무디 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count)잔 적립 완료"
    }

}

class Coffee: StarBucksMenu, OrderSystem {
    func recommanEventMenu() {
        print("커피 베이컨 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count * 2)잔 적립 완료"
    }
    
    
}



//프로토콜 프로퍼티 : 타입과 get, set만 명시
//연산 프로퍼티 / 저장 프로퍼티 상관없다. 둘다 구현가능
//디자인 관련해서 묶어주고 싶을때를 가정

//@objc optional를 사용하면 선택적 구현을 할 수 있도록 만들 수 있다.
@objc
protocol NavigationUIProtocol {
    var titleString: String { get set }
    @objc optional var mainTintColor: UIColor { get } //get만 사용한 경우, get은 필수, set은 선택사항이다.(set을 구현해도 되고 안해도 된다)
}


class JackViewController: UIViewController, NavigationUIProtocol {
    
    //저장 프로퍼티를 사용
    var titleString: String = "나의 일기"
    var mainTintColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleString
        view.backgroundColor = mainTintColor
    }
    
}

class Jack2ViewController: UIViewController, NavigationUIProtocol {
    var titleString: String {
        get {
            return "나의 일기"
        }
        
        set {
            title = newValue
        }
    }
    
    var mainTintColor: UIColor {
        return .black
//        get {
//            return .black
//        }
//
//        set {
//            view.backgroundColor = newValue
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleString = "새로운 일기"
    }
    
}





