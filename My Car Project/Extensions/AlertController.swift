//
//  AlertController.swift
//  My Car Project
//
//  Created by Kirill Frolovskiy on 17.04.2023.
//

import UIKit

extension UIAlertController {

    static func createAlertController(withTitle title: String) -> UIAlertController {
        UIAlertController(title: title, message: "Введите сколько вы потратили?", preferredStyle: .alert)
    }

    func action(expenses: Expenses?, completion: @escaping (String) -> Void) {
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Amount"
            textField.text = expenses?.title
        }
    }
}
