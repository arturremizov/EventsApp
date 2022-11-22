//
//  EditEventViewController.swift
//  EventsApp
//
//  Created by Artur Remizov on 22.11.22.
//

import UIKit

class EditEventViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EditEventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK: - Setup
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AddEventCell.self, forCellReuseIdentifier: String(describing: AddEventCell.self))
        tableView.tableFooterView = UIView()
        
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(didTapDone))
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: - Actions
    @objc private func didTapDone() {
        viewModel.didTapDone()
    }
}

// MARK: - UITableViewDataSource
extension EditEventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddEventCell.self),
                                                     for: indexPath) as! AddEventCell
            cell.update(with: titleSubtitleCellViewModel)
            cell.subtitleTextField.delegate = self
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension EditEventViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: - UITextFieldDelegate
extension EditEventViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            viewModel.updateCell(indexPath: indexPath, subtitle: text)
        }
        return true
    }
}
