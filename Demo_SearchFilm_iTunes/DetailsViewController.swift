//
//  DetailsViewController.swift
//  Demo_SearchFilm_iTunes
//
//  Created by Thien Tung on 6/2/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import AVKit

class DetailsViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    } ()
    
    let trackNameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.text = "TrackName"
        lb.textColor = .black
        lb.numberOfLines = 1
        return lb
    } ()
    
    let artistLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.text = "artist"
        lb.textColor = .black
        return lb
    } ()
    
    let trackPriceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.text = "price"
        lb.textColor = .black
        return lb
    } ()
    
    let countryLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.text = "Country"
        lb.textColor = .black
        return lb
    } ()
    
    let imageTrack: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .blue
        return image
    } ()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        return button
    } ()
    
    let watchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("WATCH DEMO", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.layer.cornerRadius = 10.0
        return button
    } ()
    
    var data: Itune?
    var urlPreview: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addComponents()
        setupLayout()
        setupButton()
        getData()
        
    }
    
    func getData() {
        if let data = data {
            trackNameLb.text = "Track: \(String(describing: data.filmName ?? ""))"
            artistLb.text = "Artist: \(String(describing: data.artistName ?? ""))"
            trackPriceLb.text = "Price: \(String(describing: data.trackPrice ?? 0)) $"
            countryLb.text = "Country: \(String(describing: data.country ?? ""))"
            imageTrack.kf.setImage(with: URL(string: data.imageURL ?? ""))
            urlPreview = data.previewUrl ?? ""
            //print(urlPreview)
        }
    }
    
    func addComponents() {
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(imageTrack)
        containerView.addSubview(trackNameLb)
        containerView.addSubview(artistLb)
        containerView.addSubview(trackPriceLb)
        containerView.addSubview(countryLb)
        containerView.addSubview(watchButton)
    }
    
    func setupLayout() {
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24).isActive = true
        backButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        
        imageTrack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        imageTrack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 80).isActive = true
        imageTrack.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageTrack.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        trackNameLb.leftAnchor.constraint(equalTo: backButton.leftAnchor, constant: 16).isActive = true
        trackNameLb.topAnchor.constraint(equalTo: imageTrack.bottomAnchor, constant: 40).isActive = true
        
        artistLb.leftAnchor.constraint(equalTo: trackNameLb.leftAnchor, constant: 0).isActive = true
        artistLb.topAnchor.constraint(equalTo: trackNameLb.bottomAnchor, constant: 10).isActive = true
        
        trackPriceLb.leftAnchor.constraint(equalTo: trackNameLb.leftAnchor, constant: 0).isActive = true
        trackPriceLb.topAnchor.constraint(equalTo: artistLb.bottomAnchor, constant: 10).isActive = true
        
        countryLb.leftAnchor.constraint(equalTo: trackNameLb.leftAnchor, constant: 0).isActive = true
        countryLb.topAnchor.constraint(equalTo: trackPriceLb.bottomAnchor, constant: 10).isActive = true
        
        watchButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        watchButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        watchButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        watchButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50).isActive = true
    }
    
    func setupButton () {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        watchButton.addTarget(self, action: #selector(watchDemo), for: .touchUpInside)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func watchDemo() {
        
        let url = URL(string: urlPreview)!
        playVideo(url: url)
    }
    
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)

        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.present(playerVC, animated: true) { playerVC.player?.play() }
    }
    
}
