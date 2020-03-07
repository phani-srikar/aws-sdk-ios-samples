//
//  SignInViewController.swift
//  S3TransferUtilitySampleSwift
//
//  Created by Edupuganti, Phani Srikar on 3/6/20.
//  Copyright © 2020 Amazon. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI
import AWSMobileClient

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                switch(userState){
                case .signedIn:
                    if let storyboard = self.storyboard {
                       let tabViewController = storyboard.instantiateViewController(withIdentifier:"tabBarController")
                        self.present(tabViewController, animated: true, completion: nil)
                    }
                case .signedOut:
                    AWSMobileClient.default().showSignIn(navigationController: self.navigationController!,
                                                         signInUIOptions: SignInUIOptions(
                                                             canCancel: false
                                                         )) { signInState, error in
                        guard error == nil else {
                            print("error logging in: \(error!.localizedDescription)")
                            return
                        }

                        guard let signInState = signInState else {
                            print("signInState unexpectedly empty in \(#function)")
                            return
                        }

                        switch signInState {
                        case .signedIn:
                            if let storyboard = self.storyboard {
                               let tabViewController = storyboard.instantiateViewController(withIdentifier:"tabBarController")
                                self.present(tabViewController, animated: true, completion: nil)
                            }
                        default: return
                        }
                    }
                default:
                    AWSMobileClient.default().signOut()
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
    }
}
