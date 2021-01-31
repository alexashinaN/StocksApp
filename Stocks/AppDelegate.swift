//
//  AppDelegate.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let presenter = StocksPresenter(service: NetworkService(session: URLSession.shared))
		let view = StocksViewController(output: presenter)
		presenter.view = view
				
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = view
		self.window = window
		self.window?.makeKeyAndVisible()

		return true
	}
}
