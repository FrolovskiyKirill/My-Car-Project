//
//  Button Block View.swift
//  My Car Project
//
//  Created by Kirill Frolovskiy on 13.04.2023.
//

import UIKit

/// ```
/// Данный класс создает StackView c 4 кастомными кнопками и UILabel
/// ```
final class ButtonBlockView: UIStackView {

  let buttonSystemName = ["fuelpump", "car.front.waves.up", "wrench.and.screwdriver", "dollarsign.square"]
  let buttonsActions = [#selector(someFunc), #selector(someFunc), #selector(someFunc), #selector(someFunc)]

  init() {
    super.init(frame: .zero)
    configureLabel()
    configureButtons()
    configureUIStack()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureButtons() {

    // Создание UIStackView с кастомными кнопками
    let buttonsStackView = UIStackView()
    buttonsStackView.axis = .horizontal
    buttonsStackView.spacing = 20
    buttonsStackView.alignment = .center
    buttonsStackView.distribution = .fillEqually

    // Создание кастомных кнопок и добавление их в buttonsStackView
    for systemName in buttonSystemName {
      let customButton = CustomButton(backgroundColor: .systemGray2, systemName: systemName)
      buttonsStackView.addArrangedSubview(customButton)
      for action in buttonsActions {
        customButton.addTarget(self, action: action, for: .touchUpInside)
      }
    }
    addArrangedSubview(buttonsStackView)
  }

  private func configureLabel() {
    let label = UILabel()
    label.text = "Add your expenses"
    label.font = UIFont.boldSystemFont(ofSize: 22)
    addArrangedSubview(label)
  }

  private func configureUIStack() {
    axis = .vertical
    spacing = -5
    alignment = .leading
    distribution = .fillEqually
  }

  //Метод пока является заглушкой.
  @objc private func someFunc() {
    print("Doy")
  }
}

//Test commit
