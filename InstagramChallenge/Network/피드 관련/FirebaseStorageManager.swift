//
//  FirebaseStorageManager.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/05.
//

import UIKit
import FirebaseStorage
import Alamofire
import Kingfisher

class FirebaseStorageManager {
    static func uploadImage(image: UIImage?, pathRoot: String, completion: @escaping (URL?) -> Void) {
        guard let imageData = image!.jpegData(compressionQuality: 0.9) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let firebaseReference = Storage.storage().reference().child("\(pathRoot)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                let urlString = url!.absoluteString
                print("download url returned: \(urlString)")
                completion(url)
            }
        }
    }
}



