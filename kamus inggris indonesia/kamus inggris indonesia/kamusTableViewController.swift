//
//  kamusTableViewController.swift
//  kamus inggris indonesia
//
//  Created by abdul fatah on 11/9/17.
//  Copyright © 2017 FatahKhair. All rights reserved.
//


import UIKit
import SwiftyJSON
import Alamofire



class kamusTableViewController: UITableViewController {
    let kamusURL = "http://localhost/CodeIgniter/index.php/Api/getKamus"
    var kamusData = [KamusModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllDataKamus()
        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kamusData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! kamusTableViewCell
        
        // Configure the cell...
        cell.english.text = kamusData[indexPath.row].kamus_inggris
        cell.indonesia.text = kamusData[indexPath.row].kamus_indonesia
        
        return cell
    }
    
    
    //membuat method baru dengan nama : getLatestLoans()
    func getAllDataKamus() {
        //deklarasi loanUrl untuk memanggil variable kivaLoanURL yang telah di deklarasi sebelumnya
        guard let loanUrl = URL(string: kamusURL) else {
            return //return ini berfungsi untuk mengembalikan nilai yang sudah di dapat ketika memanggil variable loanUrl
        }
        
        //deklarasi request untuk request URL loanUrl
        let request = URLRequest(url: loanUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return//mengembalikan nilai error yang di dapat
            }
            
            // Parse JSON data
            //deklarasi variable data untuk memanggil data
            if let data = data {
                //pada bagian ini akan memanggil method parseJsonData yang akan kita buat di bawah
                self.kamusData = self.parseJsonData(data: data)
                
                //reload table view
                OperationQueue.main.addOperation({
                    //reloadData kembali
                    self.tableView.reloadData()
                })
            }
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    //membuat method baru dengan nama ParseJsonData
    //method ini akan melakukan parsing data json
    func parseJsonData(data: Data) -> [KamusModel] {
        //deklarasi variable loans sebagai object dari class Loan
        var loans = [KamusModel]()
        //akan melakukan perulangan terhadap data json yang di parsing
        do {
            //deklarasi jsonResult untuk mengambil data dari json nya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse JSON data
            //deklarasi jsonResult untuk mengambil data dari json nya
            let jsonLoan = jsonResult?["data"] as! [AnyObject]
            //akan melakukan pemanggilan data berulang ulang selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonLoan in jsonLoan {
                //deklarasi loan sebagai object dari class Loan
                let loan = KamusModel()
                //memasukkan nilai ke dalam masing masing object dari class Loan
                //memasukkan nilai jsonLoan dengan nama object nama sebagai string
                loan.kamus_indonesia = jsonLoan["kamus_indonesia"] as! String
                //memasukkan nilai jsonLoan dengan nama object loan_amount sebagai integer
                loan.kamus_inggris = jsonLoan["kamus_inggris"] as! String
                kamusData.append(loan)
            }
            
        } catch {
            print(error)
        }
        
        return kamusData
    }
    
}



