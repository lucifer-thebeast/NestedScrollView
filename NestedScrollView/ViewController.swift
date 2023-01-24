//
//  ViewController.swift
//  NestedScrollView
//
//  Created by Ronillo Ang on 1/20/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(DetailView(frame: view.bounds))
    }
}
