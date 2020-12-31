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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        updateView()
    }
    
    private func updateView() {
        let storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        let MapVC = storyborad.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let seeImageVC = storyborad.instantiateViewController(withIdentifier: "SeeImageViewController") as! SeeImageViewController
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            remove(asChildViewController: MapVC)
            
            add(asChildViewController: seeImageVC)
        } else {
            remove(asChildViewController: seeImageVC)
            add(asChildViewController: MapVC)
        }
    }
    private func add(asChildViewController viewController: UIViewController) {
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
    }
    @IBAction func tapSegmentedControl(_ sender: UISegmentedControl) {
        
        updateView()
    }
    
}
