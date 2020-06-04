//
//  ViewController.swift
//  Demo_SearchFilm_iTunes
//
//  Created by Thien Tung on 5/25/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datas: [Itune] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        setupSearchBar()
        setupColectionView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupColectionView() {
        collectionView.backgroundColor = .black
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    func getAPI(_ searchText: String) {
        //Khởi tạo link url
        let url = String(format: "https://itunes.apple.com/search?term=%@&limit=20", searchText)
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let urlRequest = URL(string: urlString) else {
            return
        }
        
        AF.request(urlRequest, method: .get, encoding: URLEncoding.default).responseJSON { [weak self] (response) in
            
            guard let strongSelf = self else {
                return
            }
            
            switch response.result {
            case .success(let value):
                let data = iTuneObject(json: JSON(value))
                if let results = data.results {
                    strongSelf.datas = results
                    strongSelf.collectionView.reloadData()
                    //  print(strongSelf.datas[0].filmName ?? "")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.item = datas[indexPath.row]
        cell.backgroundColor = .systemPink
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((collectionView.frame.size.width - 10) / 2)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailsViewController()
        detailVC.data = datas[indexPath.row]
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText), \(datas.count)")
        getAPI(searchText)
        collectionView.reloadData()
    }
}
