//
// Copyright (c) 2017 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

/// The NavigationController class is an internally used subclass of UINavigationController.
/// It customizes its appearance based on the given appearance configuration on initialization.
internal class NavigationController: UINavigationController {
    
    /// Initializes the navigation controller.
    ///
    /// - Parameters:
    ///   - rootViewController: The view controller that resides at the bottom of the navigation stack.
    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        delegate = self
        viewControllers = [rootViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let appearanceConfiguration = AppearanceConfiguration.shared
        
        navigationBar.titleTextAttributes = appearanceConfiguration.navigationBarTitleTextAttributes
        navigationBar.tintColor = appearanceConfiguration.navigationBarTintColor
        navigationBar.barTintColor = appearanceConfiguration.navigationBarBackgroundColor
        navigationBar.isTranslucent = appearanceConfiguration.isNavigationBarTranslucent
        
        if #available(iOS 11, *) {
            navigationBar.prefersLargeTitles = appearanceConfiguration.navigationBarLargeTitleDisplayMode != .never
            navigationBar.largeTitleTextAttributes = appearanceConfiguration.navigationBarLargeTitleTextAttributes
        }
    }
    
}

// MARK: Delegate

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let appearanceConfiguration = AppearanceConfiguration.shared
        viewController.view.backgroundColor = appearanceConfiguration.backgroundColor
        
        let navigationItem = viewController.navigationItem
        
        // Hide the back button title for all view controllers in the navigation stack.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        
        if #available(iOS 11, *) {
            // Configure large title display mode.
            switch appearanceConfiguration.navigationBarLargeTitleDisplayMode {
            case .always:
                navigationItem.largeTitleDisplayMode = .always
            case .never:
                navigationItem.largeTitleDisplayMode = .never
            case .root:
                let isRootViewController = viewController == navigationController.viewControllers.first
                navigationItem.largeTitleDisplayMode = isRootViewController ? .always : .never
            }
        }
    }
    
}
