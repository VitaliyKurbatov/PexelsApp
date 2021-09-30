//
//  TabBarController.swift
//  PexelsAPI
//
//  Created by Vitaliy on 25.01.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    private let photosVC: PhotosListVC
    private let videosVC: VideosListVC
    
    init(photosVC: PhotosListVC, videosVC: VideosListVC) {
        self.photosVC = photosVC
        self.videosVC = videosVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupViewControllers()
    }
    
    private func setupAppearance() {
        view.backgroundColor = ColorPalette.shared.whiteMutable
        UITabBar.appearance().barTintColor = ColorPalette.shared.whiteMutable
        tabBar.tintColor = ColorPalette.shared.blackMutable
    }
    
    private func setupViewControllers() {
        let photoIcon = UIImage(named: "photo_black_36pt")!
        let videoIcon = UIImage(named: "video_black_36pt")!
        
        viewControllers = [
            wrapNavController(for: photosVC, title: "Photos", image: photoIcon),
            wrapNavController(for: videosVC, title: "Videos", image: videoIcon)
        ]
    }
    
    private func wrapNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        return navController
    }
}
