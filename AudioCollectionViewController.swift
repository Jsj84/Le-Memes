//
//  AudioCollectionViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/7/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit
import AVFoundation

class AudioCollectionViewController: UICollectionViewController, AVAudioPlayerDelegate, AudioCollectionCellDelegate {
    
    let playerViewController = PlayerViewController()
    let managedObject = ManagedObject()
    var audioPlayer: AVAudioPlayer!
    var session: AVAudioSession!
    var settings = [String : Int]()
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObject.getVoices()
        collectionView?.delegate = self
        
        let voice = UIBarButtonItem(title: "Record", style: .plain, target: self, action: #selector(gotToNextView))
        self.navigationItem.rightBarButtonItem = voice
        
        collectionView?.backgroundColor = UIColor.black
        self.collectionView!.register(AudioCollectionCell.self, forCellWithReuseIdentifier: "cell2")
        
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
        } catch { print("Had an issue starting the shared session Jesse") }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! AudioCollectionCell
        cell.delegate = self
        return cell
    }
    
    func deleteButtonTapped(cell: AudioCollectionCell) {
        guard let indexPath = self.collectionView?.indexPath(for: cell) else { return }
        managedObject.deleteVoice(index: (indexPath.item))
        self.collectionView?.deleteItems(at: [indexPath])
    }
    
    func previewButtonTapped(cell: AudioCollectionCell) {
        guard let indexPath = self.collectionView?.indexPath(for: cell) else { return }
        preparePlayer(i: indexPath.item)
    }
    
    func useButtonTapped(cell: AudioCollectionCell) {
        guard let indexPath = self.collectionView?.indexPath(for: cell) else { return }
        defaults.set(indexPath.item, forKey: "voiceRecording")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func gotToNextView() {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    func preparePlayer(i: Int) {
        do {
            let file = managedObject.voices[i].value(forKey: "voiceRecording") as! Data
            audioPlayer = try AVAudioPlayer(data: file)
            audioPlayer.delegate = self
            audioPlayer.play()
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
