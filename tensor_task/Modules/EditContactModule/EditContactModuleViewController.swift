//
//  EditContactModuleViewController.swift
//  tensor_task
//
//  Created by Sergey on 30.09.2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import RxKeyboard

class EditContactModuleViewController: UIViewController {
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    fileprivate let items = BehaviorRelay<[EditContactSection]>(value: [])
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.register(EditContactCell.self, forCellReuseIdentifier: "EditContactCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = view.bounds.height
        tableView.backgroundColor = UIColor(named: "ContactBackground")
        //tableView.delegate = self
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configure(contact: ContactModel? = nil) {
        items.accept([.contactSection(items: [.contactItem(contact: contact)])])
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "ContactBackground")
        items.asObservable().bind(to: tableView.rx.items(dataSource: dataSource())).disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
          .drive(onNext: { [weak tableView] keyboardVisibleHeight in
            tableView?.contentInset.bottom = keyboardVisibleHeight + 50
          })
          .disposed(by: disposeBag)
    }
    
    fileprivate func dataSource() -> RxTableViewSectionedReloadDataSource<EditContactSection> {
        return RxTableViewSectionedReloadDataSource<EditContactSection>(
            configureCell: { (dataSource, tableView, indexPath, _) in
                switch dataSource[indexPath] {
                case .contactItem(contact: let contact):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "EditContactCell", for: indexPath) as! EditContactCell
                    cell.configure(contact: contact)
                    return cell
                }
            })
    }
}

/// UIView Constraints --------------------------------------
extension EditContactModuleViewController {
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

fileprivate enum EditContactSectionItems {
    case contactItem(contact: ContactModel?)
}

fileprivate enum EditContactSection {
    case contactSection(items: [EditContactSectionItems])
}

extension EditContactSection: SectionModelType {
    
    typealias Item = EditContactSectionItems
    
    var items: [EditContactSectionItems] {
        switch self {
        case .contactSection(items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: EditContactSection, items: [EditContactSectionItems]) {
        switch original {
        case .contactSection(items: let items):
            self = .contactSection(items: items)
        }
    }
}
