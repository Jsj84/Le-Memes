//
//  ViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var voiceButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    let defaults = UserDefaults()
    var audioPlayer: AVAudioPlayer!
    var session: AVAudioSession!
    var settings = [String : Int]()
    var chosenSound:String? = nil
    var sound:String? = nil
    let managedObject = ManagedObject()
    
    @IBAction func voiceButton(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "AudioCollectionViewController") as! AudioCollectionViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func faceButton(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "face") as! CollectionViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func playButton(_ sender: Any) {
        if playButton.titleLabel?.text == "Play" {
            audioPlayer.play()
            playButton.backgroundColor = UIColor.red
            playButton.setTitle("Stop", for: .normal)
        }
        else {
            audioPlayer.stop()
            playButton.backgroundColor = UIColor.green
            playButton.setTitle("Play", for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
        } catch {
            print("Could not load sound")
        }
  
        self.view.backgroundColor = UIColor.black
        imageView.image = #imageLiteral(resourceName: "questionMark.png")
        
        // design buttonView box
        playButton.backgroundColor = UIColor.green
        playButton.setTitle("Play", for: .normal)
        playButton.layer.cornerRadius = 70
        
        self.view.bringSubview(toFront: imageView)
        self.view.bringSubview(toFront: playButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        managedObject.getVoices()
        self.imageView.layer.cornerRadius = imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 2
        
        self.imageView.layer.borderColor = UIColor.black.cgColor
        if defaults.value(forKey: "image") != nil {
            let data = defaults.object(forKey: "image") as! NSData
            imageView.image = UIImage(data: data as Data)
           
        }
        else {
            imageView.image = #imageLiteral(resourceName: "questionMark.png")
        }
        if defaults.value(forKey: "tempIndexPath") != nil {
            do {
                let i = defaults.value(forKey: "tempIndexPath") as! Int
                let file = managedObject.voices[i].value(forKey: "voiceRecording") as! Data
                audioPlayer = try AVAudioPlayer(data: file)
                audioPlayer.delegate = self
            } catch{
                if let err = error as Error? {
                    print("AVAudioPlayer error: \(err.localizedDescription)")
                    audioPlayer = nil
                }
            }
        }
        else {
        sound = Bundle.main.path(forResource: "trump_wall", ofType: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            }
        catch {
            print(error)
        }
     }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
