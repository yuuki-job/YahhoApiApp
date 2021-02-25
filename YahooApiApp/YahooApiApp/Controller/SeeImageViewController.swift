//
//  seeImageViewController.swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2020/11/10.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SeeImageViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var imageDisplayView: UIImageView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var catchCopyLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var storeTitleLabel: UILabel!
    
    //MARK: - Properties
    var data:String?
    var seeAdress:String?
    var displayData:[YahooApiData] = []
    var index = 0
    let border = CALayer()
    // ボタンを用意
    var addBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageDisplayView.layer.cornerRadius = 20.0
        catchCopyLabel.layer.cornerRadius = 20.0
        //storeTitleLabelのデザイン
        storeTitleLabel.storeLabelDesign()
        
        adressLabel.layer.borderColor = UIColor.black.cgColor
        
        adressLabel.text = displayData[index].adress
        catchCopyLabel.text = displayData[index].catchCopy
        ratingLabel.text = displayData[index].rating
        storeTitleLabel.text = displayData[index].name
        //genreNameLabel.text = displayData[index].genreName
        
        if let leadImageString = displayData[index].leadImage{
            AF.request(leadImageString).responseImage { (response) in
                
                if let leadImage = response.value{
                    self.imageDisplayView.image = leadImage
                }
            }
        }
        //ラベルのボトムに線を引く
        border.frame = CGRect(x: 0, y: adressLabel.frame.height - 0.3, width: self.view.frame.width, height: 0.3)
        border.backgroundColor = UIColor.black.cgColor
        adressLabel.layer.addSublayer(border)
        
        //コードでrightBarButtonItemを書いた
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "地図", style: .plain, target: self, action: #selector(nextButton))
    }
    @objc func nextButton() {
        
        //mapViewControllerに送る
        let mapVC = self.storyboard?.instantiateViewController(identifier: "map") as! MapViewController
        mapVC.yahooApiData = displayData
        mapVC.indexNum = index
        //performSegue(withIdentifier: "next", sender: nil)
        
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
}
