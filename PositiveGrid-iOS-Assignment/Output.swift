//
//  Output.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/14.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

internal final class Output: SigPathViewComponent {
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect.zero)
    
        self.type = .output
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
