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
    
    var player: ToggleableButton = ToggleableButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = Bundle.main.path(forResource: "examMIDI", ofType: "mid")
        let url = URL.init(fileURLWithPath: urlPath!)
        sequence = try! MIKMIDISequence(fileAt: url)
   
        configurePlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sequencer.sequence = sequence
        sequencer.startPlayback()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - View Configuration
    private func configurePlayer() {
        player.setTitle("Audio Player", for: .normal)
        
        player.center = view.center
        
        _ = player.status.observeNext { [unowned self] (status) in
            // TODO: Optimization without if-else statement
            if status == .Off {
                self.sequencer.stop()
            }else {
                self.sequencer.resumePlayback()
            }
        }

        view.addSubview(player)
    }
}

