//
//  Input.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/14.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

internal final class Input: SigPathViewComponent, Toggleable {
    var status: Property<ToggleableStatusEnum> = Property(.On)
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect.zero)
    
        self.type = .input
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        _ = reactive.tap.observeNext { [unowned self] _ in
            self.status.next(self.status.value == .On ? .Off : .On)
        }
        
        _ = status.observeNext { [unowned self] (status) in
            self.alpha = status == .On ? 1 : 0.5
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
