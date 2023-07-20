//
//  ViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/17/23.
//

import UIKit
import GoogleSignIn
import RealmSwift


class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
                let fullName = user!.profile?.name
                let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
                feedPage.fullName = fullName!
                self.present(feedPage, animated: false, completion: nil)
            }
          }
    }
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            
            let idToken = user.idToken?.tokenString
            let credentials = Credentials.googleId(token: idToken!)
            
            if let app_id = Bundle.main.infoDictionary?["APP_ID"] as? String {
                let app = App(id: app_id)
                app.login(credentials: credentials) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .failure(let error):
                                print("Failed to log in to MongoDB Realm: \(error)")
                            case .success(_):
                                print("Successfully logged in to MongoDB Realm using Google OAuth.")
                                // Now logged in, do something with user
                                // Remember to dispatch to main if you are doing anything on the UI thread
                                // If sign in succeeded, display the app's main content View.
                                let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
                                self.present(feedPage, animated: false, completion: nil)
                            }
                        }
                    }
            }
          }
    }
    
}

