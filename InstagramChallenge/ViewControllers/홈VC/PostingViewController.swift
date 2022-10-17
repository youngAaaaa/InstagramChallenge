//
//  PostingViewController.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/03.
//

import UIKit

class PostingViewController: UIViewController {
    
    @IBAction func tapBackButton(_ sender: Any) {
        textView.text = ""
        dismiss(animated: false)
    }
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    
    @IBOutlet weak var okButton: UIButton!
    @IBAction func tapOKButton(_ sender: Any) {
        self.textView.endEditing(true)
        okButton.isHidden = true
        shareButton.isHidden = false
    }
    
    let ms = Date.currentTimeInMilli()
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func tapShareButton(_ sender: UIButton) {
        
        FirebaseStorageManager.uploadImage(image: receiveimg,
                                           pathRoot: "day/\(Constant.loginID ?? "")/day_\(ms).jpg"){ [self] url in
            let urlString = url!.absoluteString
            
            if self.textView.text == "문구 입력..." {
                textView.text = ""
            }
            
            let request = CreateFeedRequest(feedText: self.textView.text, contentsUrls: [urlString])
            CreateFeedDataManager().postFeed(request, delegate: self)
        }
    }
    
    // MARK: 뷰
    @IBOutlet weak var bgView: UIView!
    
    
    // MARK: 사진
    var receiveimg: UIImage?
    @IBOutlet weak var postingImage: UIImageView!
    
    
    // MARK: 텍스트 뷰
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    func configureView(){
        dismissKeyboardWhenTappedAround()
        postingImage.image = receiveimg
        
        bgView.layer.opacity = 0
        
        textView.delegate = self
        textView.textColor = UIColor.systemGray
        textView.text = "문구 입력..."
    }
}
extension PostingViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        headerLabel.text = "문구"
        bgView.layer.opacity = 0.8
        
        okButton.isHidden = false
        shareButton.isHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 1000{
            textView.deleteBackward()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "문구 입력..."
            textView.textColor = UIColor.systemGray
        }
        bgView.layer.opacity = 0
        dismissKeyboardWhenTappedAround()
        headerLabel.text = "새 게시물"
        
        okButton.isHidden = true
        shareButton.isHidden = false
    }
}
