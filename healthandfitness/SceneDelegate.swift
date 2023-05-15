//
//  SceneDelegate.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-05.
//

import UIKit
import SwiftKeychainWrapper
import LGSideMenuController

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {return}
        let myWindow = UIWindow(windowScene: scene)
        
        if KeychainWrapper.standard.bool(forKey: "isLoggedIn") != nil  {
            if KeychainWrapper.standard.bool(forKey: "isLoggedIn") ?? false {
                if KeychainWrapper.standard.bool(forKey: "isWizardCompleted") != nil  {
                    if KeychainWrapper.standard.bool(forKey: "isWizardCompleted") ?? false {
                        let sideMenuController = LGSideMenuController()
                        sideMenuController.rootViewController = HomeViewController()
                        sideMenuController.rightViewController = SideMenuViewController()
                        sideMenuController.rightViewPresentationStyle = .slideBelowShifted
                        sideMenuController.rightViewWidth = (UIScreen.main.bounds.width / 3) * 2
                   
                        myWindow.rootViewController = UINavigationController(rootViewController: sideMenuController)
                    }else{
                        
                        let layout = UICollectionViewFlowLayout()
                        layout.scrollDirection = .horizontal
                        
                        
                        
                        myWindow.rootViewController = UINavigationController(rootViewController: WizardController(collectionViewLayout: layout))
                    }
                }else{
                    
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    
                    
                    
                    myWindow.rootViewController = UINavigationController(rootViewController: WizardController(collectionViewLayout: layout))
                    
                }
                
                
            }else{
                
                myWindow.rootViewController =  UINavigationController(rootViewController: LoginViewController())
                
            }
        }else{
            
            myWindow.rootViewController =  UINavigationController(rootViewController: LoginViewController())
            
        }
        self.window = myWindow
        myWindow.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

