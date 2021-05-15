//
//  LoginViewController.swift
//  Moviefy
//
//  Created by Rick Jacobson on 5/15/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        APIClient.shared.createRequestToken() { (result) in
            switch result {
            case let .success(token):
                DispatchQueue.main.async {
                    print(token.request_token)
                    self.authorizeRequestToken(from: self, requestToken: token.request_token)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func authorizeRequestToken(from viewController: UIViewController, requestToken: String) {
        // Create a URL with our token
        guard let authURL = URL(string: "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=moviefy://auth") else {return}
        let scheme = "auth"
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) { callbackURL, error in
            // Make sure it worked
            guard error == nil, let callbackURL = callbackURL else {return}
            
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            print(queryItems!)
            guard let requestToken = queryItems?.first(where: { $0.name == "request_token" })?.value else {return}
            let approved = (queryItems?.first(where: { $0.name == "approved" })?.value == "true")
            
            print("Request token \(requestToken) \(approved ? "was" : "was NOT") approved")
            
            self.startSession(requestToken: requestToken) { success in
                print("Session started")
            }

        }
        session.presentationContextProvider = self
        session.start()

    }
    
    func startSession(requestToken: String, completion: @escaping (Bool) -> Void) {
        APIClient.shared.createSession(requestToken: requestToken) { (result) in
            switch result {
            case let .success(session):
                DispatchQueue.main.async {
                    print(session.session_id)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }

}
