//
//  ExpensesListViewControllerTableViewController.swift
//  My Car Project
//
//  Created by Kirill Frolovskiy on 17.04.2023.
//

import UIKit

class ExpensesListViewController: UITableViewController {

  private let cellID = "cell"
  private var extenses = ExpensesModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
  }

  override func viewWillAppear(_ animated: Bool) {
    setupView()
  }

  private func setupView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    view.backgroundColor = .white
    setupNavigationBar()
  }

  private func setupNavigationBar() {
    title = "Expenses List"
    navigationController?.navigationBar.prefersLargeTitles = true

    // Navigation bar appearance
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithOpaqueBackground()
    navigationController?.navigationBar.standardAppearance = navBarAppearance
    navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

    // Add button to navigation bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .plain,
      target: self,
      action: #selector(addNewTask)
    )
  }

  @objc private func addNewTask() {
    showAlert()
  }

  private func save(expeseName: String) {
    StorageManager.shared.create(expeseName) { task in
      self.extenses.title.append(task)
      self.tableView.insertRows(
        at: [IndexPath(row: self.extenses.title.count - 1, section: 0)],
        with: .automatic
      )
    }
  }

  private func fetchData() {
    StorageManager.shared.fetchData { result in
      switch result {
      case .success(let extenses):
        self.extenses.title = extenses
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension ExpensesListViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    extenses.title.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    let extense = extenses.title[indexPath.row]
    var content = cell.defaultContentConfiguration()
    content.text = extense.title
    cell.contentConfiguration = content
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ExpensesListViewController {
  // Edit task
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let extense = extenses.title[indexPath.row]
    showAlert(expense: extense) {
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
  }

  // Delete task
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let extense = extenses.title.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      StorageManager.shared.delete(extense)
    }
  }
}

extension ExpensesListViewController {
  private func showAlert(expense: Expenses? = nil, completion: (() -> Void)? = nil) {
    let title = expense != nil ? "Update Task" : "New Task"
    let alert = UIAlertController.createAlertController(withTitle: title)

    alert.action(expenses: expense) { expenseName in
      if let expense = expense, let completion = completion {
        StorageManager.shared.update(expense, newName: expenseName)
        completion()
      } else {
        self.save(expeseName: expenseName)
      }
    }
    present(alert, animated: true)
  }
}
