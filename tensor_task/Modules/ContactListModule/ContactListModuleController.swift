//
//  ContactListModuleController.swift
//  tensor_task
//
//  Created by Sergey on 29.09.2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxDataSources
import RxSwift

class ContactListModuleController: UIViewController {
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    fileprivate let items = BehaviorRelay<[ContactListSection]>(value: [])
    
    let testData = [ContactModel(name: "Лидия", surname: "Сидорович", contactPhone: "+7 922 195 43 43", post: "Начальник отдела по недвижемости в городе Снежинск", workPhone: "+7 (923) 123-32-32"), ContactModel(name: "Сергей", surname: "Иванов", contactPhone: "+7 (922) 195-84-34", birthday: "05.02.1998"), ContactModel(name: "Алексей", surname: "Чечел", contactPhone: "+7 (922) 195-84-34", birthday: "05.02.1998"), ContactModel(name: "Иван", surname: "Кукил", contactPhone: "+7 (922) 195-84-34", birthday: "05.02.1998")]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.isUserInteractionEnabled = true
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0
        tableView.backgroundColor = UIColor(named: "ContactBackground")
        tableView.delegate = self
        view.addSubview(tableView)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        navigationItem.title = "Контакты"
        navigationController?
          .navigationBar
          .largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: .bold) ]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "ContactBackground")
        
        items.asObservable().bind(to: tableView.rx.items(dataSource: dataSource())).disposed(by: disposeBag)
        items.accept([.colleaguesSection(header: "Коллеги", items: testData.filter({ $0.contactType == .colleague }).map({ .contactItem(contact: $0) })), .friendsSection(header: "Друзья", items: testData.filter({ $0.contactType == .friend }).map({ .contactItem(contact: $0) }))])
        tableView.rx.modelSelected(ContactListSectionItems.self)
            .subscribe(onNext: { [weak self] item in
                switch item {
                case .contactItem(contact: let contact):
                    /// TODO Router
                    let vc = EditContactModuleViewController()
                    vc.configure(contact: contact)
                    self?.navigationController?.pushViewController(vc, animated: true)
                break
                }
            }).disposed(by: disposeBag)
    }
    
    fileprivate func dataSource() -> RxTableViewSectionedReloadDataSource<ContactListSection> {
        return RxTableViewSectionedReloadDataSource<ContactListSection>(
            configureCell: { (dataSource, tableView, indexPath, _) in
                switch dataSource[indexPath] {
                case .contactItem(contact: let contact):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
                    cell.configure(contact: contact)
                    return cell
                }
            }) { dataSource, index in
            return dataSource.sectionModels[index].header
        }
    }
}

/// UIView Constraints --------------------------------------
extension ContactListModuleController {
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ContactListModuleController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let title = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: section), let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.frame = header.bounds
    
        header.textLabel?.text = title + " (\(tableView.numberOfRows(inSection: section)))"
        header.textLabel?.textAlignment = .center
        header.tintColor = UIColor(named: "ContactBackground")
    }
}

fileprivate enum ContactListSectionItems {
    case contactItem(contact: ContactModel)
}

fileprivate enum ContactListSection {
    case friendsSection(header: String, items: [ContactListSectionItems])
    case colleaguesSection(header: String, items: [ContactListSectionItems])
}

extension ContactListSection: SectionModelType {
    
    typealias Item = ContactListSectionItems
    
    var items: [ContactListSectionItems] {
        switch self {
        case .friendsSection(header: _, items: let items):
            return items.map {$0}
        case .colleaguesSection(header: _, items: let items):
            return items.map {$0}
        }
    }
    
    var header: String {
        switch self {
        case .friendsSection(header: let header, items: _):
            return header
        case .colleaguesSection(header: let header, items: _):
            return header
        }
    }
    
    init(original: ContactListSection, items: [ContactListSectionItems]) {
        switch original {
        case .friendsSection(header: let header, items: let items):
            self = .friendsSection(header: header, items: items)
        case .colleaguesSection(header: let header, items: let items):
            self = .colleaguesSection(header: header, items: items)
        }
    }
}
