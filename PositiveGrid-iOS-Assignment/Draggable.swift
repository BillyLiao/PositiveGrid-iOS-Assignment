//
//  Draggable.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/14.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import UIKit
import Bond

protocol Draggable {
    var originAnchorPoint: CGPoint { get set }
    var targetAnchorPoint: Observable<CGPoint> { get set }
    weak var sigPath: SigPathView? { get set }
}
