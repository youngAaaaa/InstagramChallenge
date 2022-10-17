//
//  PhotoCollectionViewCell.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/03.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var representedAssetIdentifier: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
