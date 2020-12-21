//
//  TimeEaterChildViewController.swift
//  MealTime
//
//  Created by Igor Kupreev on 9/26/18.
//  Copyright © 2018 Igor Kupreev. All rights reserved.
//

import UIKit

class TimeEaterChildViewController: UIViewController {

    private var imageContainer: UIImageView!
    private var animationTimer: Timer?
    
    var file: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        imageContainer = UIImageView()
        imageContainer.contentMode = .scaleAspectFit
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.alpha = 0

        view.addSubview(imageContainer)
        let viewsDictionary: [String: Any] = ["imgView": imageContainer]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgView]|", metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imgView]|", metrics: nil, views: viewsDictionary))

        animationTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(animateImageView), userInfo: nil, repeats: true)
        
        if let path = file {
            let img = UIImage(named: path)
            imageContainer.image = img
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageContainer.alpha = 0
        
        UIView.animate(withDuration: 3) {
            self.imageContainer.alpha = 1
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        animationTimer = nil
    }
    
    @objc func animateImageView() {
        
        imageContainer.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 3) {
            self.imageContainer.transform =  CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
}
