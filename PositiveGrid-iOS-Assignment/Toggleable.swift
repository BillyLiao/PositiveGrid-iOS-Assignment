//
//  Toggleable.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/9.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation

enum ToggleableStatusEnum {
    case On
    case Off
}

protocol Toggleable {
    var status: ToggleableStatusEnum { get set }
}


