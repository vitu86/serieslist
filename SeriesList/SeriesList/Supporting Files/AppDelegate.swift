//
//  AppDelegate.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let navigation = UINavigationController()
		AppCoordinator.shared.navigation = navigation

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigation

		window?.makeKeyAndVisible()

		return true
	}
}

