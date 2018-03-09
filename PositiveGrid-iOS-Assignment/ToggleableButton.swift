//
//  ToggleableButton.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/9.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

internal final class ToggleableButton: UIButton, Toggleable {
    var status: ToggleableStatusEnum = .On {
        didSet {
            self.alpha = status == .On ? 1 : 0.5
        }
    }
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        setTitleColor(UIColor.black, for: .normal)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 3.0
        clipsToBounds = true
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        reactive.tap.observeNext {
            self.status = self.status == .On ? .Off : .On
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
