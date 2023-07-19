//
//  ViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/17/23.
//

import UIKit
import GoogleSignIn

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

            let emailAddress = user.profile?.email

            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName

            // If sign in succeeded, display the app's main content View.
            let feedPage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
            feedPage.fullName = fullName!
            self.present(feedPage, animated: false, completion: nil)

          }
    }
    
}

