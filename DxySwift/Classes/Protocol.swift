//
//  Protocol.swift
//  DxySwift
//
//  Created by dangxy on 2020/8/21.
//

import Foundation

/// 代理协议
protocol Protocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
