//
//  CheckPermission.swift
//  MockApp-SwipeTodo-CategoryTodo
//
//  Created by 近藤米功 on 2022/04/14.
//

import Foundation
import Photos

class CheckPermission{
    func checkAlbum(){
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized:
                print("authorized")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .limited:
                print("limited")
            @unknown default:
                break
            }
        }
    }
}
