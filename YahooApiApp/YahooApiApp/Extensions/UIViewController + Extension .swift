//
//  UIViewController + Extension .swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2021/02/25.
//  Copyright © 2021 yuuki. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    public func storeLabelDesign() {
        layer.shadowColor = UIColor.black.cgColor //影の色を決める
        layer.shadowOpacity = 1 //影の色の透明度
        layer.shadowRadius = 8 //影のぼかし
        //影の方向　width、heightを負の値にすると上の方に影が表示される
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }
}
