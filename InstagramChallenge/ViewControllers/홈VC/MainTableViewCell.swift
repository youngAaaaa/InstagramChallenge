//
//  MainTableViewCell.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/03.
//

import UIKit

protocol MainCellDelegate {
    func tapMoreButton(index: Int)
    //func CommentsButtonAction(index: Int)
}

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var inputText: UILabel!
    @IBOutlet weak var postId: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var idx = 0
    var Delegate:MainCellDelegate?
    
    @IBAction func tapMoreButton(_ sender: UIButton) {
        self.Delegate?.tapMoreButton(index: idx)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
