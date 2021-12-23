//
//  UploadImage.swift
//  Social Media Test
//
//  Created by Hendy Rusnanto on 22/12/21.
//

import SwiftUI
import Firebase

func UploadImage(imageData: Data, path: String, completion: @escaping (String) -> ()) {
    
    let storage = Storage.storage().reference()
    let uid = Auth.auth().currentUser!.uid
    
    storage.child(path).child(uid).putData(imageData, metadata: nil) { (_, err) in
        
        if err != nil {
            completion("")
            return
        
        // Downloading Url and Sent it Back...
        
        storage.child(path).child(uid).downloadURL { url, err in
            if err != nil {
                completion("")
                return
            }
            completion("\(url!)")
            }
        }
    }
}
