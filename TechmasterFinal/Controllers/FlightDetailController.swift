//
//  FlightDetailController.swift
//  TechmasterFinal
//
//  Created by Toàn Nguyễn on 12/12/18.
//  Copyright © 2018 mobile. All rights reserved.
//

import UIKit
import Alamofire

class FlightDetailController: UIViewController {

    var flightNo: String?
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSector: UILabel!
    @IBOutlet weak var lblFlightDate: UILabel!
    @IBOutlet weak var lblFlightNo: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GetData(flight: flightNo)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func GetData(flight: String?) {
        if (flight == nil) {
            return
        }
        Alamofire.request("http://localhost:31689/api/flights/\(flight ?? "VN0")", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    do {
                        let decoder = JSONDecoder()
                        let flight = try decoder.decode(FlightItem.self, from: response.data!)
                        self.lblFlightNo.text = flight.flightNo
                        self.lblFlightDate.text = flight.flightDate
                        self.lblSector.text = flight.sector
                        self.lblStatus.text = flight.flightStatus.uppercased()
                        self.lblStatus.textColor = UIColor.red
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
}
