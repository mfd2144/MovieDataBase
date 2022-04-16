//
//  ViewController.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import UIKit
import NetworkLayer

class ViewController: UIViewController {
    var manager:NetworkManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = NetworkManager()
        manager.getNewMovies(kind: .upcoming(page: 1)) { movie, error in
          
        }
    }


}

