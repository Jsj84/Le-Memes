//
//  Record.swift
//  Le Meme
//
//  Created by Jesse on 3/30/18.
//  Copyright © 2018 Jesse. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var settings = [String : Int]()
    let defaults = UserDefaults()
    var tempI = Int()
    
    let managedObject = ManagedObject()
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordButton.setTitle("Tap to Record", for: .normal)
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
    }
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            self.audioRecorder.delegate = self
            
        } catch {
            finishRecording(success: false)
        }
        do {
            try recordingSession.setActive(true)
            self.audioRecorder.record()
            self.recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            print("Caught exeption with recording")
        }
    }
    func finishRecording(success: Bool) {
        audioRecorder.stop()
       var key = 0
        if success {
            if defaults.value(forKey: "voiceIndexCounter") == nil {
                defaults.set(key, forKey: "voiceIndexCounter")
            }
            if (defaults.value(forKey: "voiceIndexCounter") as! Int) >= 0 {
                key = defaults.value(forKey: "voiceIndexCounter") as! Int
            }
            do {
            let audioData =  try Data(contentsOf: audioRecorder.url)
                managedObject.saveVoice(voice: audioData, index: key)
                key = key + 1
                defaults.set(key, forKey: "voiceIndexCounter")
            } catch{
                print("You caught an exemption tyring to save to core data")
            }
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
        }
        audioRecorder = nil
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
        
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
