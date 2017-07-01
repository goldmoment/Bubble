//
//  ViewController.swift
//  Bubble
//
//  Created by goldmoment on 07/01/2017.
//  Copyright (c) 2017 goldmoment. All rights reserved.
//

import UIKit
import Bubble

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        Bubble.showLogo()
        
        Bubble.maskColor = UIColor.black
        Bubble.showLogo(with: .scaleAspectFill, touchable: false)
    }
}
