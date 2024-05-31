//
//  SwiftTestViewController.swift
//  
//
//  Created by clover on 01/06/24.
//

import UIKit
import Alamofire

public class SwiftTestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var button: UIButton!
    var emails: [String] = []

    public var onEmailSelected: ((String) -> Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupButton()
        fetchEmails()
    }

    private func setupTableView() {
        tableView.frame = CGRect(x: 15, y: 20, width: self.view.frame.width - 30 , height: 400)
        setupUI(view: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }

    private func setupButton() {
        button = UIButton(type: .system)
        setupUI(view: button)
        button.setTitle("Return To App", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height - 200)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(button)
    }

    private func fetchEmails() {
        let url = "https://reqres.in/api/users?page=1"
        AF.request(url).responseJSON { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                    self.emails = result.data.map { $0.email }
                    self.tableView.reloadData()
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }
    }

    @objc private func buttonTapped() {
        if let firstEmail = emails.first {
            onEmailSelected?(firstEmail)
            self.dismiss(animated: true, completion: nil)
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = emails[indexPath.row]
        return cell
    }
}

extension SwiftTestViewController{
    private func setupUI(view : UIView) {
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.cornerRadius = 3
    }
}

struct ApiResponse: Decodable {
    let data: [User]
}

struct User: Decodable {
    let email: String
}

