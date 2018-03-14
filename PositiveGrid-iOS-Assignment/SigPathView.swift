//
//  SigPathView.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/14.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

internal class SigPathView: UIView {

    // MARK: - View Component
    open private(set) var input: Input = Input()
    private var pedals: [Pedal] = []
    private var output: Output = Output()
    
    private var allComponents: [SigPathComponent] {
        var _allComponents: [SigPathComponent] = []
        
        _allComponents.append(input)
        pedals.forEach{ _allComponents.append($0) }
        _allComponents.append(output)
        
        return _allComponents
    }
    
    // MARK: - Layout Property
    private let spacing: CGFloat = 20
    private var componentHeight: CGFloat {
        return self.frame.height
    }
    private var componentWidth: CGFloat {
        let availableWidth = self.frame.width - CGFloat(20 * (1 + pedals.count))
        let averageWidth = availableWidth / CGFloat(pedals.count + 2)
        return averageWidth
    }
    
    public var availableAnchorPoints: [CGPoint] = []
    
    // MARK: - Init
    convenience init() {
        self.init(frame: CGRect.zero, pedals: [])
    }
    
    init(frame: CGRect, pedals: [Pedal]) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        self.pedals = pedals
        self.pedals.forEach{
            $0.sigPath = self
            $0.delegate = self
        }
        
        arrangeViews()
        setupAnchorPoints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func arrangeViews() {
        for (index, component) in allComponents.enumerated() {
            component.frame.size = CGSize(width: componentWidth, height: 100)
            component.frame.origin.x = CGFloat(index) * (componentWidth + spacing)
            
            self.addSubview(component)
        }
    }
    
    private func setupAnchorPoints() {
        pedals.forEach{
            $0.sigPath = self
            $0.originAnchorPoint = $0.center
            availableAnchorPoints.append($0.center)
        }
    }
}

extension SigPathView: PedalDelegate {
    func shouldRearrangePedal(on originPoint: CGPoint, to targetPoint: CGPoint) {
        let filteredPedals = pedals.filter{ $0.originAnchorPoint == originPoint }
        if let pedal = filteredPedals.first {
            pedal.targetAnchorPoint.next(targetPoint)
        }
    }
}
