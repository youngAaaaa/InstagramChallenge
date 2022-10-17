//
//  PopUpViewController.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/07.
//

import UIKit

protocol BottomSheetDelegate{
    func updatePost(index: Int)
    func deletePost(index: Int)
}

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var linkView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var idx = 0
    var delegate:BottomSheetDelegate?
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func tapButtons(_ button: UIButton) {
        if button.titleLabel?.text == "수정" {
            print("‼️\(button.titleLabel?.text ?? "")")
            dismiss(animated: true)
            self.delegate?.updatePost(index: idx)
        } else {
            print("‼️\(button.titleLabel?.text ?? "")")
            dismiss(animated: true)
            self.delegate?.deletePost(index: idx)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareView.layer.cornerRadius = 10
        linkView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = 10
    }
    
}
