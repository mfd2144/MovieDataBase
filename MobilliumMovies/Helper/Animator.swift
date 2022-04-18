//
//  Animator.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 18.04.2022.
//

import UIKit

public class Animator {

    public static let sharedInstance = Animator()
    var transpranView = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init(){
        transpranView.frame = UIScreen.main.bounds
        transpranView.backgroundColor = UIColor.black
        transpranView.isUserInteractionEnabled = true
        transpranView.alpha = 0.5
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = transpranView.center
        indicator.startAnimating()
        indicator.color = .yellow
    }

    func showAnimation(){
        DispatchQueue.main.async{
            guard let controller = appContainer.appRouter.getTopVC() else {return}
//            appContainer.router.window?.addSubview(self.transpranView)
//            appContainer.router.window?.addSubview(self.indicator)
            controller.view.addSubview(self.transpranView)
            controller.view.addSubview(self.indicator)
            controller.view.bringSubviewToFront(self.transpranView)
            controller.view.bringSubviewToFront(self.indicator)
        }
    }
    func hideAnimation(){

        DispatchQueue.main.async( execute:
            {
                self.transpranView.removeFromSuperview()
                self.indicator.removeFromSuperview()
        })
    }
}
