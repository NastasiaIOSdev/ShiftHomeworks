//
//  EmployeesViewController.swift
//  CompanyList
//
//  Created by Анастасия Ларина on 08.06.2022.
//

import UIKit
import SnapKit
import CoreData

class EmployeesViewController: UIViewController {

    var getEmployeeInfo: Employee?
    var arrayOfEmployees : [Employee] = []{
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var nameTextField: UITextField?
    var ageTextField: UITextField?
    var positionTextField: UITextField?
    var experienceTextField: UITextField?
    var educationTextField: UITextField?
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 209/255, green: 32/255, blue: 35/255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Список сотрудников"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addEmployee))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.tableView.backgroundColor = .white
        self.tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        self.setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc
    func addEmployee(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Добавить сотрудника.", message: "Пожалуйста, введите данные нового сотрудника в поле ниже:", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { [unowned self] action in
            guard let textField = alertController.textFields?.first, let nameToAdd = textField.text else { return }
            self.save(addEmployee)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Выйти", style: .destructive, handler: nil)
       
        alertController.addTextField(configurationHandler: nameTextField)
        alertController.addTextField(configurationHandler: ageTextField)
        alertController.addTextField(configurationHandler: positionTextField)
        alertController.addTextField(configurationHandler: experienceTextField)
        alertController.addTextField(configurationHandler: educationTextField)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func nameTextField(textField: UITextField!) {
        nameTextField = textField
        nameTextField?.placeholder = "Имя"
    }
    
    func ageTextField(textField: UITextField!) {
        ageTextField = textField
        ageTextField?.placeholder = "Возраст"
    }
    
    func positionTextField(textField: UITextField!) {
        positionTextField = textField
        positionTextField?.placeholder = "Должность"
    }
    
    func experienceTextField(textField: UITextField!) {
        experienceTextField = textField
        experienceTextField?.placeholder = "Опыт работы"
    }
    
    func educationTextField(textField: UITextField!) {
        educationTextField = textField
        educationTextField?.placeholder = "Образование"
    }
    
    func save(_ sender: Any) {
        guard let appDeleagte = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDeleagte.persistentContainer.viewContext
        let employeeEntity = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: managedContext) as! Employee

        
        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Не получилось сохранить компанию !", err)
        }
    }
}

extension EmployeesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier, for: indexPath)
            configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell: EmployeeTableViewCell = cell as? EmployeeTableViewCell {
            let dict = arrayOfEmployees[indexPath.row] as! Employee
            cell.nameLabel.text = dict.name
            cell.ageLabel.text = dict.age
            cell.positionLabel.text = dict.position
            cell.experienceLabel.text = dict.experience
            cell.educationalLabel.text = dict.education
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEmployees.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let dict = arrayOfEmployees[indexPath.row] as! Employee
        let name = dict.name
        
        arrayOfEmployees.remove(at: indexPath.row)
        self.deleteData(name: name!)
    }
}

private extension EmployeesViewController {
    func setupLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(150)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension EmployeesViewController {
    func deleteData(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
}
