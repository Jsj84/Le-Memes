//
//  AudioCollectionViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/7/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit
import AVFoundation
private let reuseIdentifier = "cell2"

class AudioCollectionViewController: UICollectionViewController, AVAudioPlayerDelegate {
    
    let playerViewController = PlayerViewController()
    let managedObject = ManagedObject()
    var audioPlayer: AVAudioPlayer!
    var session: AVAudioSession!
    var settings = [String : Int]()
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let voice = UIBarButtonItem(title: "Record", style: .plain, target: self, action: #selector(gotToNextView))
        self.navigationItem.rightBarButtonItem = voice
        
        collectionView?.backgroundColor = UIColor.black
        
        // Register cell classes
        self.collectionView!.register(AudioCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        managedObject.getVoices()
        collectionView?.reloadData()
        
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return managedObject.voices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AudioCollectionCell
        cell.lable.text = "\(managedObject.voices[indexPath.item].value(forKey: "id") as! Int)"
            return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        managedObject.getVoices()
        preparePlayer(i: indexPath.item)
        defaults.set(indexPath.item, forKey: "tempIndexPath")
        audioPlayer.play()
    }
    @objc func gotToNextView() {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    @objc func previewButton(index: Int) {
      preparePlayer(i: index)
    }
    func preparePlayer(i: Int) {
        do {
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
