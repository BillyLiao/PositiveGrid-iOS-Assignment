//
//  CGPointExtention.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/14.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func distance(to targetPoint: CGPoint) -> CGFloat{
        let xDist = (self.x - targetPoint.x)
        let yDist = (self.y - targetPoint.y)
        let distance = sqrt(xDist * xDist + yDist * yDist)
        
        return distance
    }
}
