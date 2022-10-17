//
//  SelectPhotoViewController.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/03.
//

import UIKit
import Photos

class SelectPhotoViewController: UIViewController {
    @IBAction func tapBackButton(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "RootViewController") as! UITabBarController
//        self.changeRootViewController(vc)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        let vc = PostingViewController(nibName:"PostingViewController", bundle: nil)
        vc.receiveimg = self.image.image
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    // MARK: 사진
    var tmpImg: UICollectionViewCell?
    @IBOutlet weak var image: UIImageView!
    
    
    var asset: PHFetchResult<PHAsset>
    
    init() {
        let phFetchOptions = PHFetchOptions()
        phFetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        self.asset = PHAsset.fetchAssets(with: phFetchOptions)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageManager = PHCachingImageManager()
    
    
    // MARK: 콜렉션 뷰
    private let cellWidth = (UIScreen.main.bounds.width) / 4
    private let kPhotoCell = "PhotoCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: kPhotoCell, bundle: nil), forCellWithReuseIdentifier: kPhotoCell)
    }
    
}

extension SelectPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return asset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCell, for: indexPath) as! PhotoCollectionViewCell
        let asset = self.asset[indexPath.item]
        let scale: CGFloat = UIScreen.main.scale // 화질 향상
        cell.representedAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: CGSize(width: cellWidth * scale, height: cellWidth * scale), contentMode: .aspectFill, options: nil) { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                if indexPath == [0, 0]{
                    self.image.image = image
                    self.tmpImg = cell
                    cell.layer.opacity = 0.2
                }
                cell.imageView.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCell, for: indexPath) as! PhotoCollectionViewCell
        let asset = self.asset[indexPath.item]
        let scale: CGFloat = UIScreen.main.scale // 화질 향상
        cell.representedAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: CGSize(width: self.image.layer.borderWidth * scale, height: 414 * scale), contentMode: .aspectFit, options: nil) { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                self.image.image = image
                if (self.tmpImg != nil){
                    let beforeCell = self.tmpImg
                    beforeCell?.layer.opacity = 1
                }
                let tmpCell = self.collectionView.cellForItem(at: indexPath)
                tmpCell?.layer.opacity = 0.2
                self.tmpImg = tmpCell
            }
        }
    }
}

extension SelectPhotoViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: self.asset) else {
            return
        }
        
        if changes.hasIncrementalChanges {
            DispatchQueue.main.async {
                self.collectionView.performBatchUpdates {
                    if let inserted = changes.insertedIndexes, !inserted.isEmpty {
                        self.collectionView.insertItems(at: inserted.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let removed = changes.removedIndexes, !removed.isEmpty {
                        self.collectionView.deleteItems(at: removed.map({ IndexPath(item: $0, section: 0) }))
                    }
                }
            }
        }
    }
}
