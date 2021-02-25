//
//  SegmentViewController.swift
//  YahooApiApp
//
//  Created by 徳永勇希 on 2020/12/30.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var sendDisplayData:[YahooApiData] = []
    var sendIndex = 0
    private var contentViewController: UIViewController? {
        didSet {
            if let viewController = contentViewController {
                containerView.subviews.forEach { $0.removeFromSuperview() }
                containerView.addSubview(viewController.view)
                viewController.view.translatesAutoresizingMaskIntoConstraints = false
                viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
                viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
                viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
                viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
                addChild(viewController)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            let seeImageVC = storyboard?.instantiateViewController(withIdentifier: "seeImageVC") as! SeeImageViewController
            seeImageVC.displayData = sendDisplayData
            seeImageVC.index = sendIndex
            contentViewController = seeImageVC
        } else {
            let mapVC = storyboard?.instantiateViewController(withIdentifier: "mapVC") as! MapViewController
            mapVC.yahooApiData = sendDisplayData
            mapVC.indexNum = sendIndex
            contentViewController = mapVC
        }
    }
    /*private func add(asChildViewController viewController: UIViewController) {
        // 子ViewControllerを追加
        addChild(viewController)
        // Subviewとして子ViewControllerのViewを追加
        view.addSubview(viewController.view)
        // 子Viewの設定
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 子View Controllerへの通知
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // 子View Controllerへの通知
        viewController.willMove(toParent: nil)
        // 子ViewをSuperviewから削除
        viewController.view.removeFromSuperview()
        // 子View Controllerへの通知
        viewController.removeFromParent()
    }*/
    @IBAction func tapSegmentedControl(_ sender: UISegmentedControl) {
        
        updateView()
    }
    
}
