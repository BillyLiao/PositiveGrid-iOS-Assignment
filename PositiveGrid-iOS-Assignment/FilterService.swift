//
//  FilterService.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/23.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import NVDSP

fileprivate protocol FilterServiceType: class {
    var availableFilters: [NVDSP] { get set }
    var onFilters: [NVDSP] { get set }
    
    func setup()

    func update(with effects: [SigPathComponentEnum])
    func apply(on data: UnsafeMutablePointer<Float>, numFrames: UInt32, numChannels: UInt32)

    func set(availableFilters: [NVDSP])
}

internal final class FilterService: FilterServiceType {
    
    open fileprivate(set) var availableFilters: [NVDSP] = [] {
        didSet {
            // sync onFilters array
            onFilters = availableFilters
        }
    }
    open fileprivate(set) var onFilters: [NVDSP] = []
    
    init(){
        setup()
    }
    
    // MARK: Setup
    func setup() {
        // default setup
        guard
            let lowPassFilter = NVLowpassFilter(samplingRate: 44100),
            let highPassFilter = NVHighpassFilter(samplingRate: 44100)
        else { return } // should throw error
        
        lowPassFilter.q = 0.8
        lowPassFilter.cornerFrequency = 800
    
        highPassFilter.q = 0.5
        highPassFilter.cornerFrequency = 2000
        
        availableFilters = [lowPassFilter, highPassFilter]
    }
    
    // MARK: Public Methods
    func update(with effects: [SigPathComponentEnum]) {
        self.onFilters.removeAll(keepingCapacity: true)
        
        // Update on filters array
        effects.forEach { [unowned self] (effect) in
            switch effect {
            case .lowPassFilter: self.onFilters.append(self.availableFilters.filter{ $0 is NVLowpassFilter }.first!)
            case .highPassFilter: self.onFilters.append(self.availableFilters.filter{ $0 is NVHighpassFilter }.first!)
            default: break
            }
        }
    }
    
    func apply(on data: UnsafeMutablePointer<Float>, numFrames: UInt32, numChannels: UInt32) {
        onFilters.forEach{ $0.filterData(data, numFrames: numFrames, numChannels: numChannels)}
    }
    
    // MARK: Setter
    // if set availableFilters manually, onFilters will be set at the same time
    func set(availableFilters: [NVDSP]) {
        self.availableFilters = availableFilters
    }
}
