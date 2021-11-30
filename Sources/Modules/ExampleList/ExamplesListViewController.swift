//
//  ExampleListViewController.swift
//  CollectionViewLayoutExamples
//

import UIKit

class ExampleListViewController: BaseViewController {
    private let tableView = UITableView()
    
    private let viewModel: ExampleListViewModel
    
    init(viewModel: ExampleListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectSelectedRow()
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.constraintsSupport.makeConstraints { make in
            make.edgesEqualTo(view)
        }
        tableView.register(ExampleListCell.self, forCellReuseIdentifier: ExampleListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func deselectSelectedRow() {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.deselectRow(at: indexPath, animated: false)
        }, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension ExampleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectElement(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension ExampleListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.reuseIdentifier, for: indexPath)
        (cell as? CommonCell)?.configure(with: cellViewModel)
        return cell
    }
}
