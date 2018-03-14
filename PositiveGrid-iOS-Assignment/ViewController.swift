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
    
    var playButton: ToggleableButton = ToggleableButton()
    
    let midiURLPath = Bundle.main.path(forResource: "examMIDI", ofType: "mid")
    let soundFontURLPath = Bundle.main.path(forResource: "soundFont", ofType: "sf2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if loadMIDI() { sequencer.sequence = sequence }
        applySoundFont()
        sequencer.startPlayback()
        
        configurePlayButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    private func configurePlayButton() {
        playButton.setTitle("Audio Player", for: .normal)
        
        playButton.center = view.center
        
        _ = playButton.status.observeNext { [unowned self] (status) in
            // TODO: Optimization without if-else statement
            if status == .Off {
                self.sequencer.stop()
            }else {
                self.sequencer.resumePlayback()
            }
        }

        view.addSubview(playButton)
    }
}

