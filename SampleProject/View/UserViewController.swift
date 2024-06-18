//
//  UserViewController.swift
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userStyleLabel: UILabel!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var sleepTimeLabel: UILabel!
    @IBOutlet weak var goalsTimeLabel: UILabel!
    
    var sleepTime: Int!
    var goalsTime: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setView()
    }
    
    private func setView() {
        let userType = UserDefaults.standard.string(forKey: ConstantsKey.userType)
        userStyleLabel.text = userType
        
        switch userType {
        case "거북이":
            sleepTime = 7
            goalsTime = 3
        case "토끼":
            sleepTime = 6
            goalsTime = 5
        case "치타":
            sleepTime = 5
            goalsTime = 8
        default:
            break
        }
        
        userStyleLabel.text = userType
        sleepTimeLabel.text = "\(sleepTime!)시간"
        goalsTimeLabel.text = "\(goalsTime!)시간"
    }
    
    private func showPopup(event: @escaping ((_ result: Int) -> Void)) {
        let alert = SelectPopup(event: event)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func clickSleepTime(_ sender: UIButton) {
        showPopup(event: { result in
            self.sleepTime = result
            self.sleepTimeLabel.text = "\(result)시간"
        })
    }
    
    @IBAction func clickGoalsTime(_ sender: UIButton) {
        showPopup(event: { result in
            self.goalsTime = result
            self.goalsTimeLabel.text = "\(result)시간"
        })
    }
    
    @IBAction func clickNext(_ sender: UIButton) {
        UserDefaults.standard.set(userNameTextField.text, forKey: ConstantsKey.userName)
        UserDefaults.standard.set(startDate.date, forKey: ConstantsKey.startDate)
        UserDefaults.standard.set(endDate.date, forKey: ConstantsKey.endDate)
        
        let mainViewController = MainViewController()
        mainViewController.tomorrowSleepHour = sleepTime
        mainViewController.tomorrowGoalsHour = goalsTime
        
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}
