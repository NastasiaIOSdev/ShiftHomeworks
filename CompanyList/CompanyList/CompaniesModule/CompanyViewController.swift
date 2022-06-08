//
//  CompanyViewController.swift
//  CompanyList
//
//  Created by Анастасия Ларина on 08.06.2022.
//

import UIKit
import SnapKit
import CoreData

class CompanyViewController: UIViewController{

    var companyies: [NSManagedObject] = []
    let cellID = "cellID"
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 209/255, green: 32/255, blue: 35/255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Список компаний"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addCompany))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        self.setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Company")
        do {
            companyies = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print("Не удалось загрузить список сохраненных компаний", err)
        }
    }
    
    @objc
    func addCompany(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Добавить компанию.", message: "Пожалуйста, введите имя новой компании в поле ниже:", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { [unowned self] action in
            guard let textField = alertController.textFields?.first, let companyToAdd = textField.text else { return }
            self.save(companyToAdd)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Выйти", style: .destructive, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func save(_ companyName: String) {
        guard let appDeleagte = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDeleagte.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Company", in: managedContext)
        let company = NSManagedObject(entity: entity!, insertInto: managedContext)
        company.setValue(companyName, forKey: "companyName")
        
        do {
            try managedContext.save()
            companyies.append(company)
        } catch let err as NSError {
            print("Не получилось сохранить компанию !", err)
        }
    }
}

extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let company = companyies[indexPath.row]
        cell.textLabel?.text = company.value(forKeyPath: "companyName") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyies.count
    }
}

private extension CompanyViewController {
    func setupLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(150)
            make.leading.trailing.equalToSuperview()
        }
    }
}
