//
//  MainViewController.swift
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var turtleView: UIView!
    @IBOutlet weak var rabbitView: UIView!
    @IBOutlet weak var cheetahView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector (self.clickTurtle (_:)))
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.clickRabbit (_:)))
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector (self.clickCheetah (_:)))
        
        turtleView.addGestureRecognizer(gesture1)
        rabbitView.addGestureRecognizer(gesture2)
        cheetahView.addGestureRecognizer(gesture3)
    }
    
    @objc func clickTurtle(_ sender:UITapGestureRecognizer) {
        UserDefaults.standard.set("거북이", forKey: ConstantsKey.userType)
        goToNextViewController()
    }
    
    @objc func clickRabbit(_ sender:UITapGestureRecognizer) {
        UserDefaults.standard.set("토끼", forKey: ConstantsKey.userType)
        goToNextViewController()
    }
    
    @objc func clickCheetah(_ sender:UITapGestureRecognizer) {
        UserDefaults.standard.set("치타", forKey: ConstantsKey.userType)
        goToNextViewController()
    }
    
    private func goToNextViewController() {
//        var viewArray = self.navigationController?.viewControllers
//        viewArray!.removeLast()
//        viewArray!.append(UserViewController())
//        self.navigationController?.setViewControllers(viewArray!, animated: true)
        self.navigationController?.pushViewController(UserViewController(), animated: true)
    }
    
}
