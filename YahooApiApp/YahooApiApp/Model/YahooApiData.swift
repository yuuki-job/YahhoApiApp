//
//  YahooApiData.swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2020/10/27.
//  Copyright © 2020 yuuki. All rights reserved.
//

import Foundation
class YahooApiData:Codable{
    
    var Feature:NameString

    struct NameString: Codable {
        var Name: String
        
    }
}
