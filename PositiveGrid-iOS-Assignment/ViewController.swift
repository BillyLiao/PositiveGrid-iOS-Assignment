//
//  ViewController.swift
//  PositiveGrid-iOS-Assignment
//
//  Created by 廖慶麟 on 2018/3/8.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import MIKMIDI
import Bond

internal final class ViewController: UIViewController {

    var sequence: MIKMIDISequence!
    var sequencer = MIKMIDISequencer()
    
    let midiURLPath = Bundle.main.path(forResource: "examMIDI", ofType: "mid")
    let soundFontURLPath = Bundle.main.path(forResource: "soundFont", ofType: "sf2")
    
    // MARK: - View Component
    var sigPathView: SigPathView = SigPathView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if loadMIDI() { sequencer.sequence = sequence }
        applySoundFont()
        
        configureSigPathView()
        
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sequencer.startPlayback()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Binding
    private func bind() {
        _ = sigPathView.input.reactive.tap.observeNext {
            if self.sequencer.isPlaying {
                self.sequencer.stop()
            }else {
                self.sequencer.resumePlayback()
            }
        }
        
        _ = sigPathView.effects.observeNext { (effects) in
            // Here for observing effects sig sequence chaining in order
            // Use it to apply filter effect while Audio Processing
            print("☝🏻 Pedals chaining status: \(effects)")
        }
    }
    
    // MARK: - Basic Setup
    private func loadMIDI() -> Bool {
        guard midiURLPath != nil else { return false }
        
        let midiURL = URL.init(fileURLWithPath: midiURLPath!)
    
        do {
            sequence = try MIKMIDISequence(fileAt: midiURL)
        }catch {
            print("Failed to load midi file")
        }
        
        return true
    }
    
    @discardableResult private func applySoundFont() -> Bool {
        guard soundFontURLPath != nil else { return false }
        
        let soundFontURL = URL.init(fileURLWithPath: soundFontURLPath!)
        
        sequence.tracks.forEach { (track) in
            if let synth = sequencer.builtinSynthesizer(for: track) {
                do {
                    try synth.loadSoundfontFromFile(at: soundFontURL)
                }catch {
                    print("Failed to load soundFont of track: \(track)")
                }
            }
        }
        
        return true
    }
    
    // MARK: - View Configuration
    private func configureSigPathView() {
        let sigPathViewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 100)
        
        sigPathView = SigPathView(frame: sigPathViewFrame, pedals: [Pedal(type: .lowPassFilter), Pedal(type: .highPassFilter)])
        sigPathView.center = view.center
    
        view.addSubview(sigPathView)
    }
}

