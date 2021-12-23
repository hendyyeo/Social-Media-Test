//
//  LoginViewModel.swift
//  Social Media Test
//
//  Created by Hendy Rusnanto on 22/12/21.
//

import SwiftUI
import Firebase

class LoginViewModel : ObservableObject{
    
    @Published var code = ""
    @Published var number = ""
    
    //for any errors..
    @Published var errorMsg = ""
    @Published var error = false
    
    @Published var registerUser = false
    @AppStorage("current_status") var status = false
    
    //Loading When Searches for User...
    @Published var isLoading = false
    
    func verifyUser() {
        
        isLoading = true
        
        //Remove When Testing In Live
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let phoneNumber = "+" + code + number
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {
            (ID, err) in
            
            if err != nil {
                self.errorMsg = err!.localizedDescription
                self.error.toggle()
                self.isLoading = false
                return
            }
            
            //code sent Successfully...
            
            alertView(msg: "Enter verification Code") { (Code) in
                
                let credential =
                PhoneAuthProvider.provider().credential(withVerificationID: ID!,
                verificationCode: Code)
                
                Auth.auth().signIn(with: credential) { res, err in
                    
                    if err != nil {
                        self.errorMsg = err!.localizedDescription
                        self.error.toggle()
                        self.isLoading = false
                        return
                    }
                    
                    self.checkUser()
                }
            }
        }
    }
    
    func checkUser() {
        
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").whereField("uid", isEqualTo: uid).getDocuments {
            (snap, err) in
            
            if err != nil {
                //No Documents..
                //User Not Found...
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            
            if snap!.documents.isEmpty{
                
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            self.status = true
        }
    }
}
