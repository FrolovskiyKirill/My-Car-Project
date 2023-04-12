//
//  ViewController.swift
//  My Car Project
//
//  Created by Kirill Frolovskiy on 12.04.2023.
//

import UIKit

class MainViewController: UIViewController {

  let callToActionButton = MCButton(backgroundColor: .systemGray2, systemName: "fuelpump")

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureCallToActionButton()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
    tabBarController?.tabBar.isHidden = true
  }

  private func configureCallToActionButton() {

    view.addSubview(callToActionButton)

    //Этот код настраивает действие, которое будет выполнено, когда пользователь нажимает кнопку callToActionButton.
    callToActionButton.addTarget(self, action: #selector(alertVC), for: .touchUpInside)

    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
//      callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//      callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 80),
      callToActionButton.widthAnchor.constraint(equalToConstant: 80)
    ])
  }

  @objc func alertVC() {
    print("hello")

  }


}

