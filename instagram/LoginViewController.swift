//
//  LoginViewController.swift
//  instagram
//
//  Created by Jasmine Farrell on 3/5/16.
//  Copyright © 2016 JIFarrell. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user: PFUser?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("loggedInSegue", sender: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Sign in success")
                self.performSegueWithIdentifier("loggedInSegue", sender: nil)
                //let upcomingNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("loggedInView") as! UITabBarController
                //upcomingNavigationController.presentedViewController
                
                
            } else {
                print("Sign in failed: \(error)")
                if error?.code == 101 {
                    print("Invalid username/password")
                }
            }
            
        }

    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = username.text
        newUser.password = password.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if success {
                print("YAY! YOU SIGNED UP!!!!")
                self.performSegueWithIdentifier("loggedInSegue", sender: nil)
                // NSUserDefaults.standardUserDefaults().setObject(self.user, forKey: "user")
            } else {
                print("SO sad! Failed to sign up: \(error)")
                if error?.code == 202 {
                    print("Error... ERROR ERROR... taken! taken! your name is taken, so typical")
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
