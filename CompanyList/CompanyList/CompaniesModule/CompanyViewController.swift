//
//  CompanyViewController.swift
//  CompanyList
//
//  Created by Анастасия Ларина on 08.06.2022.
//

import UIKit
import SnapKit
import CoreData

final class CompanyViewController: UIViewController{
    
    private enum Constraints {
        static let topOffsetLabel: CGFloat = 180
    }
    
    //MARK: - Property
    
    var companyies = [Company]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let tableView = UITableView()
    
    //MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 209/255, green: 32/255, blue: 35/255, alpha: 1)
        self.setupNavigation()
        self.setupTableView()
        self.setupLayout()
        self.fetchCompany()
    }
}

// MARK: - TableView DataSourse & Delegate

extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return companyies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CompanyTableViewCell.identifier,
            for: indexPath) as? CompanyTableViewCell else { return UITableViewCell()
            }
        let company = companyies[indexPath.row]
        cell.companyLabel.text = company.companyName
        return cell
    }
    
// MARK: - delete Cell data
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.context.delete(self.companyies[indexPath.row])
        self.companyies.remove(at: indexPath.row)
        self.saveCompany()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        //        let destinationVC: Void? = self.navigationController?.pushViewController(EmployeesAssembly.build(), animated: true)
        //        if let index = tableView.indexPathsForSelectedRows?[0] {
        //            destinationVC.setectedCompany = self.companyies[indexPath.row]
        //        }
    }
}

// MARK: - Fetch & Save cellData

private extension CompanyViewController {
    func fetchCompany(with request: NSFetchRequest<Company> = Company.fetchRequest()) {
        do {
            companyies = try context.fetch(request)
        } catch {
            print("Ошибка при попытке получить Company из database")
        }
        tableView.reloadData()
    }
    
    func saveCompany() {
        do {
            try context.save()
        } catch {
            print("Ошибка при попытке сохранить Company")
        }
        tableView.reloadData()
    }
}

// MARK: - setup tableView Layout

private extension CompanyViewController {
    func setupLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(Constraints.topOffsetLabel)
            make.leading.trailing.equalToSuperview()
        }
    }
}

private extension CompanyViewController {
    func setupNavigation() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Список компаний"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .add,
            style: .plain,
            target: self,
            action: #selector(addCompany)
        )
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.tableView.register(
            CompanyTableViewCell.self,
            forCellReuseIdentifier: CompanyTableViewCell.identifier
        )
    }
}

// MARK: - Setup Alert

private extension CompanyViewController {
    @objc
    func addCompany(_ sender: Any) {
        var newCompany: String?
        let alert = UIAlertController(
            title: "Добавить компанию.",
            message: "Пожалуйста, введите имя новой компании в поле ниже:",
            preferredStyle: .alert
        )
        alert.addTextField { (nameTF) in
            nameTF.placeholder = "Имя"
        }
        let addAction = UIAlertAction(
            title: "Добавить",
            style: .default
        ) { (alertAction) in
            newCompany = alert.textFields![0].text
            let company = Company(context: self.context)
            company.companyName = newCompany
            self.companyies.append(company)
            self.saveCompany()
        }
        let cancelAction = UIAlertAction(title: "Выйти", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
}
