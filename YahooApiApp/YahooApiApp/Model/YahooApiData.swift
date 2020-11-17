//
//  YahooApiData.swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2020/10/27.
//  Copyright © 2020 yuuki. All rights reserved.
//

import Foundation

class YahooApiData {
    var name:String?
    var adress:String?
    var tellNumber:String?
    var category:String?
    var leadImage:String?
    var catchCopy:String?
    var rating:String?
    var genreName:String?
    
    
    
    init(dicData:[AnyHashable:Any]) {
        
        if let property = dicData["Property"] as? [AnyHashable: Any] {
            
            adress = property["Address"] as? String
            tellNumber = property["Tel1"] as? String
            leadImage = property["LeadImage"] as? String
            catchCopy = property["CatchCopy"] as? String
            rating = property["Rating"] as? String
            
            if let genreArry = property["Genre"] as? [[AnyHashable: Any]]{
                for genre in genreArry{
                    genreName = genre["Name"] as? String
                }
            }
        }
        if let nameData = dicData["Name"] as? String{
            name = nameData
        }
        //カテゴリー
        let categoryData = dicData["Category"] as? [String]
        if categoryData?.isEmpty == false{
            
            category = categoryData?[0]
            
        }
        //画像
        if let leadImageUrl = dicData["LeadImage"] as? String{
            leadImage = leadImageUrl
        }
        
    }
}


