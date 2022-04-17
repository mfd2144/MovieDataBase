//
//  UIview.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import Foundation
import UIKit

extension CALayer {
     func addBottomLine() {
        let border = CALayer()
         border.frame = CGRect(x: 20, y: self.frame.height-0.5, width: UIScreen.main.bounds.width-40, height: 0.5)
        border.backgroundColor = UIColor.lightGray.cgColor;
        self.addSublayer(border)
    }
    

}
