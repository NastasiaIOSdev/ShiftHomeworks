//
//  EmployeesViewController.swift
//  CompanyList
//
//  Created by Анастасия Ларина on 08.06.2022.
//

import UIKit
import SnapKit
import CoreData

class EmployeesViewController: UITableViewController {

// MARK: - Property
    
    var arrayEmployee = [Employee]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var setectedCompany: Company? {
        didSet {
            fetchEmployee()
            guard let companyNAme = setectedCompany?.name else { return }
            self.title = companyNAme
        }
    }
    
// MARK - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 209/255, green: 32/255, blue: 35/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .add,
            style: .plain,
            target: self,
            action: #selector(addEmployeeButtonTap)
        )
        
        self.tableView.register(
        EmployeeTableViewCell.self,
        forCellReuseIdentifier: EmployeeTableViewCell.identifier
       )
    }
}

// MARK: - Feth & Save CellData

extension EmployeesViewController {
    
    func fetchEmployee(
        with request: NSFetchRequest<Employee> = Employee.fetchRequest(),
        predicate: NSPredicate? = nil
    ) {
        let companyPredicate = NSPredicate(
            format: "parentCompany.name MATCHES %@",
            setectedCompany!.name!
        )
        if let additionalPredicate = predicate {
            let compoundPredicate = NSCompoundPredicate(
                andPredicateWithSubpredicates: [companyPredicate, additionalPredicate]
            )
            request.predicate = compoundPredicate
        } else {
            request.predicate = companyPredicate
        }
        
        do {
            arrayEmployee = try context.fetch(request)
        } catch {
            print("Щшибка при попытке загрузить Employee из database")
        }
        tableView.reloadData()
    }
    
    func saveEmployee() {
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении Employee")
        }
        tableView.reloadData()
    }
}

// MARK - TableViewDataSourse, TableViewDelegate

extension EmployeesViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EmployeeTableViewCell.identifier,
            for: indexPath) as? EmployeeTableViewCell else { return UITableViewCell()
            }
        let employee = arrayEmployee[indexPath.row]
        cell.nameLabel.text = employee.name
        cell.ageLabel.text = employee.age
        cell.positionLabel.text = employee.position
        cell.experienceLabel.text = employee.experience
        cell.educationalLabel.text = employee.experience
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEmployee.count
    }
    
//MARK - Remove Cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
        self.context.delete(self.arrayEmployee[indexPath.row])
        self.arrayEmployee.remove(at: indexPath.row)
        self.saveEmployee()
        }
    }
}

// MARK - Setup Alert

 extension EmployeesViewController: UITextFieldDelegate {
    @objc
    func addEmployeeButtonTap(_ sender: UIBarButtonItem) {
//        var model: EmployeeModel?
        var textField = UITextField()
        let alert = UIAlertController(
            title: "Добавить сотрудника.",
            message: "Пожалуйста, введите данные нового сотрудника в поле ниже:",
            preferredStyle: .alert
        )
    
        let saveAction = UIAlertAction(title: "Добавить", style: .default) { (alertAction) in
            if textField.text != "" {
                let newEmployee = Employee(context: self.context)
                newEmployee.name = textField.text!
                newEmployee.parentCompany = self.setectedCompany
            self.arrayEmployee.append(newEmployee)
            self.saveEmployee()
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (nameTF) in
            nameTF.placeholder = "Имя"
            textField = nameTF
        }
        alert.addTextField { (ageTF) in
            ageTF.placeholder = "Возраст"
            ageTF.keyboardType = .numberPad
        }
        alert.addTextField { (positionTF) in
            positionTF.placeholder = "Должность"
        }
        alert.addTextField { (experienceTF) in
            experienceTF.placeholder = "Опыт работы"
            experienceTF.keyboardType = .numberPad
        }
        alert.addTextField { (educattionTF) in
            educattionTF.placeholder = "Образование"
        }
        
        let cancelAction = UIAlertAction(
            title: "Выйти",
            style: .destructive, handler: nil
        )
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
}
