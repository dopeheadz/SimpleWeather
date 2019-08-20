//
//  ViewController.swift
//  SimpleWeather
//
//  Created by dope on 13/08/2019.
//  Copyright © 2019 dope. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { // 섹션을 2개로 나누는 메서드
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath)
            return cell
        default:
            fatalError()
            
        }        
    }

}
