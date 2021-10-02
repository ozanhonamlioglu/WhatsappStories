//
//  ViewController.swift
//  WhatsappStories
//
//  Created by ozan honamlioglu on 23.09.2021.
//

import UIKit

fileprivate let statusCellId = "statusCellId"

class StatusController: UITableViewController {
    
    lazy var searchBar: UISearchController = {
        var search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchResultsUpdater = self
        return search
    }()
    
    lazy var presentationView: UIView = {
        let pv = UIView()
        return pv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presentationView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panPresentation)))
        view.backgroundColor = .systemGray6
        registerCells()
        setupNavbar()
    }
    
    // MARK: - HANDLERS
    private func setupNavbar() {
        navigationItem.searchController = searchBar
        navigationItem.title = "Status"
        navigationItem.largeTitleDisplayMode = .always
        var topRightButton: UIButton {
            let btn = UIButton()
            btn.setTitle("Privacy", for: .normal)
            btn.setTitleColor(.systemBlue, for: .normal)
            return btn
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: topRightButton)
    }
    
    private func registerCells() {
        let statusCell = UINib(nibName: "StatusTableViewCell", bundle: nil)
        tableView.register(statusCell, forCellReuseIdentifier: statusCellId)
    }
    
    private func createHeaderFoSection(paintArea: CGRect, title: String) -> UIView {
        let sectionHeader = UIView(frame: paintArea)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        
        sectionHeader.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: -10),
            label.leftAnchor.constraint(equalTo: sectionHeader.leftAnchor, constant: 10)
        ])
        
        return sectionHeader
    }
    
    private func presentStatus(cell: UITableViewCell) {
        let startSize = 50
        let yPosition = cell.frame.origin.y - tableView.bounds.minY + CGFloat(startSize / 2)
        let xPosition = cell.frame.origin.x + CGFloat(startSize / 2)
        
        presentationView.removeFromSuperview()
        tabBarController?.view.addSubview(presentationView)
        presentationView.frame = CGRect(x: Int(xPosition), y: Int(yPosition), width: Int(startSize), height: Int(startSize))
        presentationView.backgroundColor = .red
        
        UIView.animate(withDuration: 0.2) {
            self.presentationView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
    }
    
    // MARK: - TABLE HANDLERS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: statusCellId) as! StatusTableViewCell

        switch indexPath.section {
        case 0:
            let data = getNotSeen()[indexPath.row]
            cell.data = data
        case 1:
            let data = getSeen()[indexPath.row]
            cell.data = data
        default:
            break
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let seen = getSeen().count
        if(seen > 0) { return 2 }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return getNotSeen().count
        } else if (section == 1) {
            return getSeen().count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionArea = tableView.rect(forSection: section)
        
        if (section == 0) {
            let theHeader = createHeaderFoSection(paintArea: sectionArea, title: "LAST UPDATES")
            return theHeader
            
        } else if (section == 1) {
            let theHeader = createHeaderFoSection(paintArea: sectionArea, title: "SEEN UPDATES")
            return theHeader
            
        } else {
            return nil
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        switch indexPath.section {
        case 0:
            presentStatus(cell: cell)
            break
        case 1:
            break
        default:
            break
        }
        
    }

}

extension StatusController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

extension StatusController {
    
    @objc private func panPresentation(_ recognizer: UIPanGestureRecognizer) {
        guard recognizer.view != nil else {
            return
        }
        
        let translations = recognizer.translation(in: tabBarController?.view)
        
    }
    
}
