/// Copyright (c) 2022-present Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

final class ViewController: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(style: .large)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 세 개의 UI 요소를 화면 밖으로 위치 시킨다.
        heading.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        
        cloud1.alpha = 0.0
        cloud2.alpha = 0.0
        cloud3.alpha = 0.0
        cloud4.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 가려진 요소들을 자연스럽게 다시 화면에 위치시킨다.
        UIView.animate(withDuration: 0.5) {
            self.heading.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            // delay: 애니메이션을 시작하기 전에 UIKit이 대기하는 시간(초)
            self.username.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            // repeat: 애니메이션이 영원히 반복됨
            // autoreverse: repeat와 함께 쓰면 정방향 역방향 애니메이션이 영원히 반복되며, 이것만 쓰면 한 번만 실행됨.
            // curveLinear: 애니메이션에 가속, 감속을 적용하지 않음
            // curveEaseIn: 애니메이션의 시작 부분에 가속 적용
            // curveEaseOut: 애니메이션의 끝 부분에 감속 적용
            // curveEaseInOut: 애니메이션 시작 시 가속을 하고, 종료 시 감속을 적용 > 가장 자연스러운 옵션
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.cloud1.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.cloud2.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
            self.cloud3.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
            self.cloud4.alpha = 1.0
        }, completion: nil)
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        view.endEditing(true)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
}
