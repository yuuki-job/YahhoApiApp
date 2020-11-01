//
//  ViewController.swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2020/10/25.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var indicateJsonData:[JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    func getApi(keyword:String){
        //indicateJsonDataの中身をすべて削除
        indicateJsonData.removeAll()
        
        guard let kyeWord = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let url = "https://map.yahooapis.jp/search/local/V1/localSearch?appid=dj00aiZpPWR4QVI4SzBLZ2xZNCZzPWNvbnN1bWVyc2VjcmV0Jng9NWE-&query=\(kyeWord)&device=mobile&output=json"
        
        AF.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
                
            case .success:
                let json = try? JSON(data: response.data!)
                print(json)
                
                let data = json?["Feature"].array
                
                for jsonData in data!{
                    self.indicateJsonData.append(jsonData)
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        getApi(keyword: searchText.text ?? "")
    }
}
extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indicateJsonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResultTableViewCell
        
        cell.storeTitle.text = indicateJsonData[indexPath.row]["Name"].string
        print(cell.storeTitle.text as Any)
        cell.streetAddress.text = indicateJsonData[indexPath.row]["Property"]["Address"].string
        print(cell.streetAddress.text as Any)
        cell.phoneNumber.text = indicateJsonData[indexPath.row]["Property"]["Tel1"].string
        print(cell.phoneNumber.text as Any)
        cell.category.text = indicateJsonData[indexPath.row]["Category"][0].string
        print(cell.category.text as Any)
        return cell
    }
}
/*
 //let name = json?["Feature"][0]["Name"].string
 let adress = json?["Feature"][0]["Property"]["Address"].string
 self.adressData.append(adress ?? "")
 let tellNumber = json?["Feature"][0]["Property"]["Tel1"].string
 self.tellNumberData.append(tellNumber ?? "")
 let category = json?["Feature"][0]["Category"][0].string
 self.categoryData.append(category ?? "")*/
