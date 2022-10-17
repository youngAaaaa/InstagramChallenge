//
//  HomeViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/28.
//

import UIKit
import Photos
import Kingfisher
import FloatingPanel

class HomeViewController: UIViewController {
    
    var feedDataList : [FeedResult] = []
    var images = [String]()
    var pageIndex = 0
    var modifyIndex = 0
    
    let refreshControl = UIRefreshControl()
    
    @IBAction func tapPostingButton(_ sender: UIButton) {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .notDetermined:
            print("not determined")
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized, .limited:
                    self.selectPhotoViewController()
                case .denied:
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)")
                        })
                    }
                default:
                    print("그 밖의 권한이 부여 되었습니다.")
                }
            }
        case .restricted:
            print("restricted")
        case .denied:
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        case .limited, .authorized:
            self.selectPhotoViewController()
        default:
            print("")
        }
    }
    
    func selectPhotoViewController() {
        DispatchQueue.main.async {
            let vc = SelectPhotoViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func tapDMButton(_ sender: UIButton) {
    }
    
    // MARK: 테이블 뷰
    @IBOutlet weak var mainTableView: UITableView!
    
    var check = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedDataList.removeAll()
        setData()
        setupView()
    }
    
    func setData(){
        GetFeedDataManager().getFeed(delegate: self)
    }
    
    private func setupView(){
        let MainTableViewCellNib = UINib(nibName: "MainTableViewCell", bundle: nil)
        mainTableView.register(MainTableViewCellNib, forCellReuseIdentifier: "MainTableViewCell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.estimatedRowHeight = 700
        mainTableView.rowHeight = UITableView.automaticDimension
        
        let StroyTableViewCellNib = UINib(nibName: "StroyTableViewCell", bundle: nil)
        mainTableView.register(StroyTableViewCellNib, forCellReuseIdentifier: "StroyTableViewCell")
        
        refreshControl.addTarget(self, action: #selector(refreshWork), for: .valueChanged)
        mainTableView.addSubview(refreshControl)
        
        pageIndex = 0
    }
    
    @objc func refreshWork() {
        refreshControl.endRefreshing()
        mainTableView.reloadData()
    }
    
    func setCell(cell: MainTableViewCell, indexPath: IndexPath) {
        cell.selectionStyle = .none
        
        cell.id.text = feedDataList[indexPath.row].feedLoginId
        cell.postId.text = feedDataList[indexPath.row].feedLoginId
        cell.inputText.text = feedDataList[indexPath.row].feedText
        cell.commentButton.setTitle("댓글 \(feedDataList[indexPath.row].feedCommentCount)개 모두 보기", for: .normal)
        cell.timeLabel.text = getTime(date: feedDataList[indexPath.row].feedCreatedAt)
        
        if feedDataList[indexPath.row].feedLoginId == Constant.loginID{
            cell.moreButton.isHidden = false
        } else {
            cell.moreButton.isHidden = true
        }
        
        images.removeAll()
        let cnt = feedDataList[indexPath.row].contentsList.count
        
        feedDataList[indexPath.row].contentsList.forEach { ContentsList in
            images.append(ContentsList.contentsUrl)
        }
        
        cell.pageControl.numberOfPages = cnt
        cell.pageControl.currentPage = 0
        
        let imageURL = URL(string: images[cell.pageControl.currentPage])
        cell.postImg.kf.setImage(with: imageURL)
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
            return feedDataList.count
            
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "StroyTableViewCell", for: indexPath) as! StroyTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
            cell.idx = indexPath.row
            cell.Delegate = self
            setCell(cell: cell, indexPath: indexPath)
            modifyIndex = indexPath.row
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    @objc func pageControlTapHandler(sender:UIPageControl) {
        print("currentPage:", sender.currentPage)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
            
        case 1:
            return UITableView.automaticDimension
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        if offset < 0 {
            pageIndex = 0
            feedDataList.removeAll()
            setData()
        } else if self.mainTableView.contentOffset.y >
                    mainTableView.contentSize.height - mainTableView.bounds.size.height {
            pageIndex += 1
            setData()
        }
    }
}

// MARK: Delegate
extension HomeViewController: MainCellDelegate{
    func tapMoreButton(index: Int) {
        setBottomSheet(tableIndex: index)
    }
    
//    func CommentsButtonAction(index: Int) {
//        <#code#>
//    }
}
extension HomeViewController: BottomSheetDelegate{
    func updatePost(index: Int){
        guard let modifyVC = self.storyboard?.instantiateViewController(identifier: "ModifyViewController") as? ModifyViewController else { return }
        
        modifyIndex = index
        
        modifyVC.feedId = feedDataList[modifyIndex].feedId
        modifyVC.receiveImgURL = feedDataList[modifyIndex].contentsList[0].contentsUrl
        modifyVC.receiveId = feedDataList[modifyIndex].feedLoginId
        modifyVC.receiveText = feedDataList[modifyIndex].feedText
        
        print("‼️modifyVC.feedId : \(modifyIndex)")
        self.changeRootViewController(modifyVC)
    }
    func deletePost(index: Int){
        let bottomSheetVC = self.storyboard?.instantiateViewController(identifier: "BottomSheetViewController") as! BottomSheetViewController
        bottomSheetVC.dismiss(animated: true)
        
        modifyIndex = index
        
        let feedId = feedDataList[modifyIndex].feedId
        print("‼️delete modifyIndex : \(feedId)")
        
        let actionSheet = makeActionSheet(alertTitle: "", alertMessage: "이 게시물을 삭제하지 않으려면 게시물을 보관할 수 있습니다. \n보관한 게시물은 회원님만 볼 수 있습니다.", feedId: feedId)
        present(actionSheet, animated: true)
    }
}
extension HomeViewController: FloatingPanelControllerDelegate{
    func setBottomSheet(tableIndex: Int) {
        let fpc = FloatingPanelController()
        let appearance = SurfaceAppearance()
        guard let vc = self.storyboard?.instantiateViewController(identifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
        
        fpc.delegate = self
        fpc.set(contentViewController: vc)
        fpc.isRemovalInteractionEnabled = true
        fpc.contentMode = .fitToBounds
        fpc.layout = MyFloatingPanelLayout()
        fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        
        appearance.cornerRadius = 10.0
        fpc.surfaceView.appearance = appearance
        
        vc.delegate = self
        vc.idx = tableIndex
        
        self.present(fpc, animated: true, completion: nil)
    }
}
class MyFloatingPanelLayout: FloatingPanelLayout {
    
    var position: FloatingPanelPosition {
        return .bottom
    }
    
    var initialState: FloatingPanelState {
        return .half
    }
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.7, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        case .half: return 0.5
        default: return 0.0
        }
    }
}
