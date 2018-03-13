import UIKit

private struct Section {
    let footerText: String?
    let items: [Item]
}

private struct Item {
    let title: String?
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let cellReuseIdentifier = "CellReuseIdentifier"
    private let footerReuseIdentifier = "FooterReuseIdentifier"
    
    private lazy var sections: [Section] = {
       let section1 = Section(footerText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", items: [Item(title: "Cell 1")])
        let section2 = Section(footerText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", items: [Item(title: "Cell 2")])
        let section3 = Section(footerText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", items: [Item(title: "Cell 3")])
        
        return [section1, section2, section3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(CustomFooter.nib, forHeaderFooterViewReuseIdentifier: footerReuseIdentifier)
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerReuseIdentifier) as? CustomFooter else {
            return nil
        }
        footer.label.text = sections[section].footerText
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footer = self.tableView(tableView, viewForFooterInSection: section) as? CustomFooter else {
            return 0
        }
        return footer.heightWithExpectedWidth(tableView.bounds.width)
    }
}

