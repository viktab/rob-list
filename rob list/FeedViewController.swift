//
//  FeedViewController.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/18/23.
//

import UIKit
import RealmSwift

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 8.0).isActive = true
        menuView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1.0).isActive = true
        if let app_id = Bundle.main.infoDictionary?["APP_ID"] as? String {
            app = App(id: app_id)
            fullName = app!.currentUser?.profile.name
            print(fullName!)
            Task {
                let realm = try await openFlexibleSyncRealm(user: app!.currentUser!)
                print("getting idols")
                let idols = realm.objects(Idol.self)
                print(idols)
                print("getting groups")
                let groups = realm.objects(Group.self)
                print(groups)
            }
        }
        nameLabel.text = "Your name is " + fullName!
    }

    @MainActor
    func openFlexibleSyncRealm(user: User) async throws -> Realm {
        print("in openSyncedRealm")
        var config = user.flexibleSyncConfiguration()
        // Pass object types to the Flexible Sync configuration
        // as a temporary workaround for not being able to add a
        // complete schema for a Flexible Sync app.
        config.objectTypes = [Group.self, Idol.self]
        let realm = try await Realm(configuration: config, downloadBeforeOpen: .always)
        print("Successfully opened realm: \(realm)")
        let subscriptions = realm.subscriptions
        // You must add at least one subscription to read and write from a Flexible Sync realm
        // (TODO) I have no idea if I'm doing this right but it works for now lol
        try await subscriptions.update {
            subscriptions.append(
                QuerySubscription<Group> {
                    $0.name != "fake name"
                })
        }
        try await subscriptions.update {
            subscriptions.append(
                QuerySubscription<Idol> {
                    $0.name != "fake name"
                })
        }
        return realm
    }
    
    var fullName : String? = ""
    var app : App?
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func searchClick(_ sender: Any) {
        let searchPage = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.present(searchPage, animated: false, completion: nil)
    }
    @IBAction func profileClick(_ sender: Any) {
        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(profilePage, animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
