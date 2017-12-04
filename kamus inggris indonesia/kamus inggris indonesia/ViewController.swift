//
//  ViewController.swift
//  kamus inggris indonesia
//
//  Created by abdul fatah on 11/9/17.
//  Copyright © 2017 FatahKhair. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var english: UITextField!
    @IBOutlet weak var indonesia: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func btnSave(_ sender: Any) {
        let nenglish = english.text!
        let nindonesia = indonesia.text!
       
        
        if ((nenglish.isEmpty) || (nindonesia.isEmpty)) {
            let alertWarning = UIAlertController(title: "Warning", message: "This is required", preferredStyle: .alert)
            let aksi = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertWarning.addAction(aksi)
            present(alertWarning, animated: true, completion: nil)
        }else{
            let params = ["kamus_indonesia": nindonesia, "kamus_inggris": nenglish]
            print(params)
            
            
            let url = "http://localhost/CodeIgniter/index.php/Api/inputData"
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (responseServer) in
                
                print(responseServer.result.isSuccess)
                
                if responseServer.result.isSuccess{
                    let json = JSON(responseServer.result.value as Any)
                    let alertWarning = UIAlertController(title: "Congrats", message: "Data berhasil disimpan", preferredStyle: .alert)
                    let aksi = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertWarning.addAction(aksi)
                    self.present(alertWarning, animated: true, completion: nil)
                    
                }
                
            })
        }
    }
}





