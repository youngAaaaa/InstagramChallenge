//
//  UIViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//

import UIKit

extension UIViewController {
    // MARK: - 빈 화면 터치하면 키보드 dismiss처리
    /// 빈 화면 터치하면 키보드 dismiss처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // MARK: UIWindow의 rootViewController를 변경하여 화면전환
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    func presentLoginAlter(id: String?){
        let makeAlert = UIAlertController(title: "계정을 찾을 수 없음", message: "\(id!)에 연결된 계정을 찾을 수 없습니다. 다른 전화번호나 이메일 주소를 사용해보세요. Instagram 계정이 없으면 가입할 수 있습니다.", preferredStyle: .alert)
        
        let actAlert1 = UIAlertAction(title: "가입하기", style: .default) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        makeAlert.addAction(actAlert1)
        
        let actAlert2 = UIAlertAction(title: "다시 시도", style: .default)
        makeAlert.addAction(actAlert2)
        
        self.present(makeAlert, animated: true)
    }
    
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(actionDone)
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      with actions: UIAlertAction ...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    public func getTime(date: String) -> String {
        let currentDate = Date().addingTimeInterval(9 * 3600)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateChangeFormat = formatter.date(from: date)!

        let minutes: Int = Int(currentDate.timeIntervalSince(dateChangeFormat)) / 60
        if minutes < 60 {
            return "\(minutes)분 전"
        }

        let hour = minutes / 60
        if hour < 24 {
            return "\(hour)시간 전"
        }
        
        let day = hour / 24
        if day < 30 {
            return "\(day)일 전"
        }
        
        formatter.dateFormat = "MM월 dd일"
        let time = formatter.string(from: dateChangeFormat)
        
        return time
    }
    
    func makeActionSheet(alertTitle: String, alertMessage: String, feedId: Int) -> UIAlertController {
        let actionSheet = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.actionSheet)
        let delete = UIAlertAction(title: "삭제", style: .destructive) { action in
            print("makeActionSheet - feedId : \(feedId)")
            DeleteFeedDataManager().deleteFeed(feedId: feedId)
        }
        let save = UIAlertAction(title: "보관", style: .default)
        actionSheet.addAction(delete)
        actionSheet.addAction(save)
        
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        actionSheet.addAction(cancle)
        
        return actionSheet
    }
    
}

