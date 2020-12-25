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
    //緯度
    var lat:String?
    //経度
    var lon:String?
    
    
    
    
    
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
        //緯度経度
        if let geometry = dicData["Geometry"] as? [AnyHashable: Any]{
            let coordinates = geometry["Coordinates"] as? String
            let splitCoordinates = coordinates?.components(separatedBy: ",")
            lat = splitCoordinates?[1]
            lon = splitCoordinates?[0]
            print(lat,lon)
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


