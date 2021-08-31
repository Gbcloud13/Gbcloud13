import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var childrenData: [Child]?
    var tableView = UITableView()
    var isAfterDataJsonCalled: Bool = false
    
    // Links.
    let dataJson = "https://www.reddit.com/.json"
    let afterDataJson = "https://www.reddit.com/.json?after=+afterlink"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        childrenData = [Child]()
        apiCall(dataJson)
    }
    
    private func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 100
        view.addSubview(tableView)
    }
    
    private func apiCall(_ jsonLink: String) {
        if let urlStr = URL(string: jsonLink) {
            var request = URLRequest(url: urlStr)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(CustomModel.self, from: data!)
                    self.childrenData?.append(contentsOf: responseModel.data?.children ?? [])
                    DispatchQueue.main.async {
                        self.tableView.tableFooterView = nil
                        self.tableView.tableFooterView?.isHidden = false
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()
                    }
                } catch {
                    print("JSON Serialization error")
                }
            }).resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.childrenData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.data = self.childrenData?[indexPath.row].data
        if tableView.isLast(for: indexPath) && isAfterDataJsonCalled == false {
            
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            isAfterDataJsonCalled = true
            self.apiCall(afterDataJson)
        }
        
        return cell
    }
}

extension UITableView {
    func isLast(for indexPath: IndexPath) -> Bool {
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}
