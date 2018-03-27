//
//  SigPathViewComponent.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/14.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

public enum SigPathComponentEnum: String {
    case input = "Audio Player"
    case output = "Output"
    case lowPassFilter = "LowPass Filter"
    case highPassFilter = "HighPass Filter"
}

internal class SigPathViewComponent: UIButton {

    var type: SigPathComponentEnum! {
        didSet {
            self.setTitle(type.rawValue, for: .normal)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor.black, for: .normal)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 3.0
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

