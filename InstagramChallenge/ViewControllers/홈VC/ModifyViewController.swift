//
//  ModifyViewController.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/07.
//

import UIKit
import Kingfisher

class ModifyViewController: UIViewController {
    
    var feedId: Int?
    
    var receiveImgURL: String?
    var receiveId: String?
    var receiveText: String?
    
    @IBOutlet weak var loginId: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func tapBackButton(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "RootViewController") as? UITabBarController else { return }
        self.changeRootViewController(vc)
    }
    
    @IBAction func tapUpdateButton(_ sender: Any) {
        let request = ModifyFeedRequest(feedText: self.textView.text)
        print("‼️self.textView.text : \(self.textView.text!)")
        
        ModifyFeedDataManager().updateFeed(self, parameters: request, feedId: feedId!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImg.kf.setImage(with: URL(string: receiveImgURL!))
        loginId.text = receiveId
        textView.text = receiveText
        
    }

}
