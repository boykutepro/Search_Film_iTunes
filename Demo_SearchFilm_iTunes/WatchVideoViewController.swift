//
//  WatchVideoViewController.swift
//  Demo_SearchFilm_iTunes
//
//  Created by Thien Tung on 6/2/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class WatchVideoViewController: UIViewController {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    var previewUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Link: \(previewUrl)")
        setupLayout()
        setupView()
        
        let url = URL(string: previewUrl)!
        
        playVideo(url: url)
    }
    
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)

        let vc = AVPlayerViewController()
        vc.player = player

        self.present(vc, animated: true) { vc.player?.play() }
    }
    
    func setupLayout() {
        view.addSubview(videoView)
        videoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        videoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        videoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        videoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    private func setupView() {
//        let path = URL(string: previewUrl)!
//        let player = AVPlayer(url: path)
//
//        let newLayer = AVPlayerLayer(player: player)
//        newLayer.frame = self.videoView.frame
//        self.videoView.layer.addSublayer(newLayer)
//        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//
//        player.play()
//        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
//
//        NotificationCenter.default.addObserver(self, selector: #selector(videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
        
        
    }
    
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
    }
}
