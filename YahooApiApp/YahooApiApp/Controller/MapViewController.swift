//
//  MapViewController.swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2020/12/19.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var yahooApiData:[YahooApiData] = []
    var indexNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(yahooApiData)
        
        //ナビゲーションのbackのところを、変えた
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "あ", style: .plain, target: nil, action: nil)
       
        mapView.showsScale = true
        
        guard let latitudeData = yahooApiData[indexNum].lat,let longitudeData = yahooApiData[indexNum].lon else {return}
        
        mapSet(latitude: Double(latitudeData)!, longitude: Double(longitudeData)!)
        print(indexNum)
    }
    func mapSet(latitude:Double,longitude:Double) {
        // 緯度・軽度を設定
        let center = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let location = MKCoordinateRegion(center: center, span: span)
        
        // マップビューに緯度・軽度を設定
        mapView.setRegion(location, animated:true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "ここです！"
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
            toolBar.tintColor = .black
            
        case 1:
            mapView.mapType = .satellite
            toolBar.tintColor = .black
        case 2:
            mapView.mapType = .hybrid
            toolBar.tintColor = .black
        case 3:
            mapView.mapType = .standard
            toolBar.tintColor = .black
            mapView.camera.pitch = 70
            mapView.camera.altitude = 700
            
        default:
            break
        }
    }
}
