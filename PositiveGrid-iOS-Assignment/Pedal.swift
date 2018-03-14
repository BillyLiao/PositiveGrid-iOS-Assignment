//
//  Pedal.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/14.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

public protocol PedalDelegate: class {
    func shouldRearrangePedalView(on originPoint: CGPoint, to targetPoint: CGPoint)
    func shouldUpdateEffects()
}

internal final class Pedal: SigPathComponent, Toggleable, Draggable {
    
    weak var sigPath: SigPathView?
    
    var originAnchorPoint: CGPoint = CGPoint.zero
    
    // MARK: - Observable
    var status: Property<ToggleableStatusEnum> = Property(.On)
    var targetAnchorPoint: Property<CGPoint> = Property(CGPoint.zero)
    
    // MARK: - Delegate
    weak var delegate: PedalDelegate?
    
    // MARK: - Init
    public convenience init(type: SigPathComponentEnum) {
        self.init(frame: CGRect.zero)
        
        self.type = type
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        _ = reactive.tap.observeNext { [unowned self] _ in
            self.status.next(self.status.value == .On ? .Off : .On)
        }
    
        _ = status.observeNext { [unowned self] (status) in
            self.alpha = status == .On ? 1 : 0.5
        }
        
        _ = reactive.panGesture().observeNext(with: { [unowned self] (pan) in
            if let parentView = self.superview {
                let location = pan.location(in: parentView)
                self.center = location
                
                var closerPoint: CGPoint?
                // var shorterDistance: CGFloat?
                var distanceWithOriginPoint: CGFloat = self.center.distance(to: self.originAnchorPoint)
                
                // Detect if current distance between center and any other candidate
                // If shorter, find the shortest
                // Else, remains the same
                self.sigPath?.availableAnchorPoints.forEach({ (point) in
                    if point != self.originAnchorPoint {
                        let distance = self.center.distance(to: point)
                        if distance < distanceWithOriginPoint {
                            closerPoint = point
                        }
                    }
                })
                
                if pan.state == .changed {
                    if let closerPoint = closerPoint {
                        self.delegate?.shouldRearrangePedalView(on: closerPoint, to: self.originAnchorPoint)
                    }
                }else if pan.state == .ended {
                    self.targetAnchorPoint.next(closerPoint ?? self.originAnchorPoint)
                    self.delegate?.shouldUpdateEffects()
                }
            }
        })
        
        _ = targetAnchorPoint.observeNext(with: { (center) in
            UIView.animate(withDuration: 0.1, animations: {
                self.originAnchorPoint = center
                self.center = center
            })
        })
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animation
    
}
