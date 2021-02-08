//
//  Visualizer.swift
//  Euro2020
//
//  Created by Stéphane Trouvé on 07/02/2021.
//

import UIKit

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        var teller:Int = 1

        if PronosB.count > 0 {

            teller = PronosB.count

        }

        return teller
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        var game: String = "No data"
        
        print(PronosB.count)

        if PronosB.count > 0 {

            game = PronosB[0][row].home_Team! + " - " + PronosB[0][row].away_Team!

        }

        return game

    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    
        visualizer(choice1: row, team1: PronosB[0][row].home_Team!, team2: PronosB[0][row].away_Team!, viewP: view1)
        
    }
    
    
    func visualizer(choice1: Int, team1: String, team2: String, viewP: UIScrollView) {
        
        let exampleview = UIScrollView()
        
        exampleview.backgroundColor = .black
        exampleview.translatesAutoresizingMaskIntoConstraints = false
        viewP.addSubview(exampleview)
        
        
        let br: CGFloat = viewP.bounds.width
        let ho: CGFloat = viewP.bounds.height

        exampleview.frame = CGRect(x: 0, y: 0, width: br, height: ho)
        
        var array = [UIView]()
        array.removeAll()
        
        let n = PronosB.count
        
        for _ in 0 ..< n {
            array.append(UIView())
        }
        
        for i in 0...n-1 {
            
            createviews(index1: i, actualview: array[i], superviewer: exampleview, numberviews: n, choice1: choice1, team1: team1, team2: team2)
        
        }
        
        exampleview.contentSize = CGSize(width: br, height: CGFloat(n) * ho / 8)
        
    }
    
    func createviews (index1: Int, actualview: UIView, superviewer: UIScrollView, numberviews: Int, choice1: Int, team1: String, team2: String) {
            
            superviewer.addSubview(actualview)
            actualview.frame = CGRect(x: 0, y: 0.05 + view.bounds.height / 8 * CGFloat(index1), width: superviewer.bounds.width, height: view.bounds.height / 8)
            actualview.backgroundColor = UIColor.init(red: CGFloat((7 + index1 * 0)) / 255, green: CGFloat((128 + index1 * 10)) / 255, blue: CGFloat((252 + index1 * 0)) / 255, alpha: 1)
            
            createlabels(type: 1, superviewer: actualview, teller: index1 + 1, choice1: choice1, team1: team1, team2: team2)
            createlabels(type: 2, superviewer: actualview, teller: index1 + 1, choice1: choice1, team1: team1, team2: team2)
            createlabels(type: 3, superviewer: actualview, teller: index1 + 1, choice1: choice1, team1: team1, team2: team2)
            createlabels(type: 4, superviewer: actualview, teller: index1 + 1, choice1: choice1, team1: team1, team2: team2)
            
            let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: actualview.bounds.width * 0.5, height: actualview.bounds.height * 0.3))
            label2.text = PronosB[index1][0].user
            label2.font.withSize(11)
            actualview.addSubview(label2)
            
        }

    
    func createlabels (type: Int, superviewer: UIView, teller: Int, choice1: Int, team1: String, team2: String ) {
        
        let x0 = superviewer.bounds.width
        let y0 = superviewer.bounds.height
        
        var x1:CGFloat = 0
        let y1 = y0 * 0.5
        let h1 = y0 * 0.2
        var w1:CGFloat = 0
        
        
        let temp1:String = team1
        var temp2:String = ""
        var temp3:String = ""
        let temp4:String = team2
        var temp5:String = ""
        
        temp2 = String(PronosB[teller-1][0].home_Goals)
        temp3 = String(PronosB[teller-1][0].away_Goals)
        
        
        if type == 1 {
        
            x1 = 0.05 * x0
            w1 = 0.30 * x0
            
            temp5 = temp1
            
        }
        
        if type == 2 {
        
            x1 = 0.40 * x0
            w1 = 0.10 * x0
            temp5 = temp2
            
        }
        
        if type == 3 {
        
            x1 = 0.50 * x0
            w1 = 0.10 * x0
            temp5 = temp3
        }
        
        if type == 4 {
        
            x1 = 0.65 * x0
            w1 = 0.30 * x0
            temp5 = temp4
            
        }
            
        let label = UILabel(frame: CGRect(x: x1, y: y1, width: w1, height: h1))
        label.textAlignment = NSTextAlignment.center
        label.text = temp5
        label.font.withSize(11)
        superviewer.addSubview(label)

        
    }
    

}
