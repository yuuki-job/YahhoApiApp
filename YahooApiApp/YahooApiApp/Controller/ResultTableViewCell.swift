//
//  ResultTableViewCell.swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2020/10/25.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storeTitle: UILabel!
    @IBOutlet weak var streetAddress: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var imageViewDisplay: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUpCell(yahooApiData:YahooApiData){
        
        storeTitle.text = yahooApiData.name
        streetAddress.text = yahooApiData.adress
        phoneNumber.text = yahooApiData.tellNumber
        category.text = yahooApiData.category
        
        if let leadImageString = yahooApiData.leadImage{
        AF.request(leadImageString).responseImage { (response) in
            print(response)
            if let image = response.value{
                self.imageViewDisplay.image = image
            }
        }
        }
    }
    
}
