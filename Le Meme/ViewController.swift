//
//  ViewController.swift
//  Le Meme
//
//  Created by Jesse on 8/6/17.
//  Copyright © 2017 Jesse. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var voiceButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    let defaults = UserDefaults()
    var audioPlayer = AVAudioPlayer()
    var sound:String? = nil
    var chosenSound:String? = nil
    
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
        
        self.view.backgroundColor = UIColor.black
        
        // design imageView box
        //self.imageView.layer.cornerRadius = 15
        imageView.backgroundColor = UIColor.white
        imageView.image = #imageLiteral(resourceName: "questionMark.png")
        
        // design buttonView box
        playButton.backgroundColor = UIColor.green
        playButton.setTitle("Play", for: .normal)
        playButton.layer.cornerRadius = 70
        
        self.view.bringSubview(toFront: imageView)
        self.view.bringSubview(toFront: playButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        if defaults.value(forKey: "image") != nil {
            let data = defaults.object(forKey: "image") as! NSData
            imageView.image = UIImage(data: data as Data)
           
        }
        else {
            imageView.image = #imageLiteral(resourceName: "questionMark.png")
        }
        sound = Bundle.main.path(forResource: "trump_wall", ofType: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound! ))
            let session = AVAudioSession.sharedInstance()
            try!  session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch{
            print(error)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
