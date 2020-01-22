//
//  SplashVC.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
   
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()

        startResourcesVC()
    }

    //MARK: StartVC
    func startResourcesVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            let startVC = ResourcesVC(nibName: "ResourcesVC", bundle: nil)
            let navVC = UINavigationController(rootViewController: startVC)
            self?.window = UIWindow(frame: UIScreen.main.bounds)
            self?.window?.rootViewController = navVC
            self?.window?.makeKeyAndVisible()
        }
    }


}
