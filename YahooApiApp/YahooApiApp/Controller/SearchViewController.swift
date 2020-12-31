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
import AlamofireImage


class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var indicateJsonData:[YahooApiData] = []
    
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
        let url = "https://map.yahooapis.jp/search/local/V1/localSearch?appid=dj00aiZpPWR4QVI4SzBLZ2xZNCZzPWNvbnN1bWVyc2VjcmV0Jng9NWE-&query=\(kyeWord)&device=mobile&output=json&"
        
        AF.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
            
            case .success(let value):
                
                
                /*if let property = value["Property"] as? [AnyHashable: Any] {
                 print(property["Address"])
                 }*/
                if let data = value as? [AnyHashable:Any],
                   let feature = data["Feature"] as? [[AnyHashable:Any]] {
                    let serchResults = feature.compactMap({ (value) -> YahooApiData? in
                        
                        let asd = value
                        
                        //電話だとvalue[0]["Property"]["Address"]　or　value["Property"]["Address"]
                        return YahooApiData(dicData: asd)
                    })
                    
                    self.indicateJsonData = serchResults
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
                print("検索結果がありません。")
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
        
        cell.setUpCell(yahooApiData: indicateJsonData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let seeImageVC = self.storyboard?.instantiateViewController(withIdentifier: "SeeImageViewController") as! SeeImageViewController
        seeImageVC.displayData = indicateJsonData
        seeImageVC.index = indexPath.row
        
        //mapViewControllerに送る
        /*let mapVC = self.storyboard?.instantiateViewController(identifier: "map") as! MapViewController
         mapVC.yahooApiData = indicateJsonData
         mapVC.indexNum = indexPath.row
         //performSegue(withIdentifier: "next", sender: nil)*/
        
        /*let segmentVC = self.storyboard?.instantiateViewController(withIdentifier: "SegmentViewController") as! SegmentViewController
         
         let mapVC = self.storyboard?.instantiateViewController(identifier: "MapViewController") as! MapViewController
         mapVC.yahooApiData = indicateJsonData
         mapVC.indexNum = indexPath.row*/
        
        self.navigationController?.pushViewController(seeImageVC, animated: true)
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


//SwiftyJSONを使ったやり方
/*func getApi(keyword:String){
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
 }*/
