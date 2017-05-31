//
//  ViewController.swift
//  TextAnimationExample
//
//  Created by ThanhNV on 5/31/17.
//  Copyright © 2017 ThanhNV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: SVGAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let clever = "M33.25,18.39c0.13,1.23-0.03,2.78-0.36,4.29C30.75,32.25,22,50.75,12.06,63.72|M27.53,41.5c0.59,0.61,0.76,1.97,0.76,3.23c0,9.55-0.02,28.43-0.03,41.27c0,4.67-0.01,8.54-0.01,10.88|M63.28,12.25c1.23,1.23,1.44,2.5,1.44,4.12c0,4.74-0.1,6.32-0.1,10|M42.45,29.46c3.36,0.78,6.62,0.36,10.03-0.16c8.73-1.31,21.67-3.04,30.01-3.88c3.35-0.4,6.72-0.32,10.09,0.23|M54.9,36.26c-0.03,1.49-0.42,2.65-1.22,3.99c-3.56,6-8.07,11.51-13.76,16.33|M76.25,33.03c6.41,4.51,11.7,9.71,14.9,15.18|M78.55,44.44c0.2,1.19,0.19,2.38-0.66,4.43C69.75,68.38,57,84.38,38.17,95.71|M53.3,52.47c7.95,11.78,14.58,21.91,27.92,34.2c3.46,3.19,7.03,6.16,11.11,8.48"
        animationView.playAnimationFromPath(clever)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

