//
//  FlightListController.swift
//  TechmasterFinal
//
//  Created by Toàn Nguyễn on 12/11/18.
//  Copyright © 2018 mobile. All rights reserved.
//

import UIKit
import Alamofire

class FlightListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var flightList:[FlightItem] = []
    
    @IBOutlet weak var tblFlightList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
    }
    
    
    
    func GetData() {
        Alamofire.request("http://localhost:31689/api/flights", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    do {
                        let decoder = JSONDecoder()
                        let flights = try decoder.decode([FlightItem].self, from: response.data!)
                        flights.forEach { flight in
                            self.flightList.append(flight)
                        }
                        print("Count: \(self.flightList.count)")
                        self.tblFlightList.reloadData()
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                    //self.alertView("Check network connection/api")
                    return
                }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flightList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FlightCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FlightTableCell  else {
            fatalError("The dequeued cell is not an instance of FlightTableCell.")
        }
        
        let flight = self.flightList[indexPath.row]
        cell.lblDetail.text = "Date: \(flight.flightDate) # Sector: \(flight.sector)"
        cell.lblFlight.text = flight.flightNo
        switch flight.flightStatus {
        case "takeoff":
            cell.img.image = UIImage(named: "takeoff")
            break;
        case "landing":
            cell.img.image = UIImage(named: "landing")
            break;
        case "flight":
            cell.img.image = UIImage(named: "flight")
            break;
        default:
            cell.img.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FlightDetailController") as? FlightDetailController
        vc?.flightNo = self.flightList[indexPath.row].flightNo
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
