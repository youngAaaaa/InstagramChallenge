//
//  LoadViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/28.
//

import UIKit

class LoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Constant.isUserLogged == false{
            guard let vc = storyboard?.instantiateViewController(identifier: "RootViewController") as? UITabBarController else{
                return
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            
        }
    }

}
