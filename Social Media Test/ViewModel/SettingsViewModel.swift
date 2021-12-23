//
//  SettingsViewModel.swift
//  Social Media Test
//
//  Created by Hendy Rusnanto on 23/12/21.
//

import SwiftUI
import Firebase
import simd

class SettingsViewModel : ObservableObject{
    
    @Published var userInfo = UserModel(username: "", pic: "", bio: "", uid: "")
    @AppStorage("current_status") var status = false
    
    //Image Picker For Updating Image...
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    
    //Loading View..
    @Published var isLoading = false
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    
    init() {
        
        fetchUser(uid: uid) { (user) in
            self.userInfo = user
        }
    }
    
    
    
    func logOut() {
        
        //loggin Out...
        
        try! Auth.auth().signOut()
        status = false
    }
    
    func updateImage() {
        
        isLoading = true
        
        UploadImage(imageData: img_Data, path: "profile_Photos") { (url) in
            
            self.ref.collection("Users").document(self.uid).updateData([
            
                "imageurl": url,
            ]) { (err) in
                if err != nil {return}
                
                //Updating View..
                self.isLoading = false
                fetchUser(uid: self.uid) { (user) in
                    self.userInfo = user
                }
            }
        }
    }
    
    func updateDetails(field : String) {
        
        alertView(msg: "Update \(field)") { (txt) in
            
            if txt != "" {
                
                self.updateBio(id: field == "Name" ? "username" : "bio", value: txt)
            }
        }
    }
    
    func updateBio(id: String, value: String) {
        
        ref.collection("Users").document(uid).updateData([
        
            id: value,
        ]) { (err) in
            
            if err != nil{return}
            
            //refereshing View...
            
            fetchUser(uid: self.uid) { (user) in
                self.userInfo = user
            }
        }
    }
}
