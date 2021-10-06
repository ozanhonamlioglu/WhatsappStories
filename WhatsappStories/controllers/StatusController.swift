//
//  ViewController.swift
//  WhatsappStories
//
//  Created by ozan honamlioglu on 23.09.2021.
//

import UIKit

fileprivate let statusCellId = "statusCellId"

enum PanDirection {
    case up, down, inactive
}

var unChangedWStartPoint = UIScreen.main.bounds.width * 3
var unChangedHStartPoint = UIScreen.main.bounds.height

var wStartPoint: CGFloat = unChangedWStartPoint
var hStartPoint: CGFloat = unChangedHStartPoint

// steps
let stepsToOval: CGFloat = 35.0
var stepsForWidth: CGFloat = (wStartPoint - UIScreen.main.bounds.width) / stepsToOval
var stepsForHeight: CGFloat = (hStartPoint - UIScreen.main.bounds.width) / stepsToOval

class StatusController: UITableViewController {
    
    var startPosition: CGFloat = 0.0
    var panDirection: PanDirection = .inactive
    var initialAlpha: CGFloat = 1
    
    lazy var searchBar: UISearchController = {
        var search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchResultsUpdater = self
        return search
    }()
    
    lazy var presentationViewBackGround: UIView = {
        let vw = UIView()
        return vw
    }()
    
    lazy var presentationView: UIView = {
        let pv = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "story")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        pv.addSubview(imageView)
        pv.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: pv.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: pv.centerXAnchor),
        ])
        
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
        
        presentationViewBackGround.removeFromSuperview()
        presentationView.removeFromSuperview()
        
        tabBarController?.view.addSubview(presentationViewBackGround)
        tabBarController?.view.addSubview(presentationView)
        
        presentationViewBackGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        presentationView.frame = CGRect(x: Int(xPosition), y: Int(yPosition), width: Int(startSize), height: Int(startSize))
        presentationView.backgroundColor = .red
        
        UIView.animate(withDuration: 0.2) {
            self.presentationView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        } completion: { status in
            self.presentationViewBackGround.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: self.initialAlpha)
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
            presentStatus(cell: cell)
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
        print(translations.x)
        
        switch recognizer.state {
        case .began:
            break
        case .ended:
            releaseTouch(y: translations.y)
            break
        case .changed:
            setPanDirection(x: translations.x, y: translations.y)
            startPosition = translations.y
            break
        default:
            break
        }
        
    }
    
    private func setPanDirection(x: CGFloat, y: CGFloat) {
        if(y > startPosition) {
            panDirection = .down
            
            if(wStartPoint > UIScreen.main.bounds.width + 1) {
                wStartPoint -= stepsForWidth
                hStartPoint -= stepsForHeight
                initialAlpha -= 0.01
                
                presentationView.ovalToCircle(wStartPoint, hStartPoint, false)
                presentationViewBackGround.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: initialAlpha)
            } else {
                
            }
            
            
        } else {
            panDirection = .up
            
            if(hStartPoint <= UIScreen.main.bounds.height) {
                wStartPoint += stepsForWidth
                hStartPoint += stepsForHeight
                initialAlpha += 0.01
                
                presentationView.ovalToCircle(wStartPoint, hStartPoint, false)
                presentationViewBackGround.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: initialAlpha)
            }
            
        }
    }
    
    private func releaseTouch(y: CGFloat) {
        if(wStartPoint >= 50) {
            self.presentationView.ovalToCircle(unChangedWStartPoint, unChangedHStartPoint, true)
            wStartPoint = unChangedWStartPoint
            hStartPoint = unChangedHStartPoint
            initialAlpha = 1
        }
    }
    
}
