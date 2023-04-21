//
//  ViewController.swift
//  My Car Project
//
//  Created by Kirill Frolovskiy on 12.04.2023.
//

import UIKit

final class MainViewController: UIViewController {

  let buttonBlockView = ButtonBlockView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureButtonBlockView()
    setupNavigationBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = false
  }

  private func setupNavigationBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Expenses",
      style: .plain,
      target: self,
      action: #selector(pushExpensesListViewController)
    )
  }

  private func configureButtonBlockView() {
    view.addSubview(buttonBlockView)

    // Настройка constraints для customStackView
    buttonBlockView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      buttonBlockView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      buttonBlockView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      buttonBlockView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
    ])
  }

  @objc private func pushExpensesListViewController() {
    let expensesListViewController = ExpensesListViewController()
    navigationController?.pushViewController(expensesListViewController, animated: true)
  }
}

