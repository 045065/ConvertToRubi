//
//  UIViewController+showAlert.swift
//  ConvertToRubi
//
//  Created by 藤枝拓弥 on 2019/07/28.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import UIKit

extension UIViewController {
    // アラート表示
    class func showAlert(viewController: UIViewController,
                         title: String,
                         message: String,
                         buttonTitle: String,
                         buttonAction: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonTitle,
                                          style: .default,
                                          handler:
            {
                (action: UIAlertAction!) -> Void in
                buttonAction?()
        })
        alertController.addAction(defaultAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
