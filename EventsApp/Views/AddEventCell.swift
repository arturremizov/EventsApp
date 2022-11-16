//
//  AddEventCell.swift
//  EventsApp
//
//  Created by Artur Remizov on 16.11.22.
//

import UIKit

final class AddEventCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    
    private let verticalStackViewPadding: CGFloat = 15
    
    private let datePickerView = UIDatePicker()
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 46))
    private lazy var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    
    private let photoImageView = UIImageView()
    
    private var viewModel: AddEventCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: AddEventCellViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        
        subtitleTextField.isHidden = viewModel.type == .image
        photoImageView.isHidden = viewModel.type != .image
        
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        
        photoImageView.backgroundColor = .black.withAlphaComponent(0.4)
        
        [verticalStackView, titleLabel, subtitleTextField, photoImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        toolbar.setItems([doneButton], animated: false)
        
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date
        photoImageView.layer.cornerRadius = 10
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalStackViewPadding),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalStackViewPadding),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: verticalStackViewPadding),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -verticalStackViewPadding),
            
            photoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Actions
    @objc private func didTapDone() {
        viewModel?.update(datePickerView.date)
    }
}
