//
//  MCButton.swift
//  My Car Project
//
//  Created by Kirill Frolovskiy on 12.04.2023.
//

import UIKit

/// ```
/// Данный класс MCButton предоставляет кастомную кнопку с настройками
/// по умолчанию, которые можно изменить через конструктор.
/// ```
class MCButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(backgroundColor: UIColor, systemName: String) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
    let image = UIImage(
      systemName: systemName,
      withConfiguration: symbolConfig)?.withTintColor(.white,renderingMode: .alwaysOriginal
      )
    self.setImage(image, for: .normal)
    configure()
  }

  private func configure() {
    layer.cornerRadius = 20
    translatesAutoresizingMaskIntoConstraints = false
  }

}
