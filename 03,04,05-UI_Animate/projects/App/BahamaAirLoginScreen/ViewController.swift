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
    
    private lazy var animationContainerView: UIView = {
        let view = UIView(frame: view.bounds)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        view.startAnimating()
        view.alpha = 0
        return view
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banner"))
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: statusImageView.frame.size.width, height: statusImageView.frame.size.height))
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    let statusMessages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(animationContainerView)
        view.addSubview(statusImageView)
                
        loginButton.addSubview(spinner)
        
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        statusImageView.center = loginButton.center
        
        statusImageView.addSubview(statusLabel)

        statusLabel.frame = CGRect(x: 0.0, y: 0.0, width: statusImageView.frame.size.width, height: statusImageView.frame.size.height)
        statusLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        statusLabel.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        statusLabel.textAlignment = .center
        
        statusPosition = statusImageView.center
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
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 가려진 요소들을 자연스럽게 다시 화면에 위치시킨다.
        UIView.animate(withDuration: 0.5) {
            self.heading.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
            // delay: 애니메이션을 시작하기 전에 UIKit이 대기하는 시간(초)
            self.username.center.x += self.view.bounds.width
          },
          completion: nil
        )
        
        /*
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
            self.password.center.x += self.view.bounds.width
          },
          completion: nil
        )*/
        
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
        
        // 각 값을 변경해보면서 실험해보자.
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            // usingSpringWithDamping: 애니메이션이 최종 상태에 가까워질 때 애니메이션에 적용되는 감쇠(damping) 또는 감소(reduction)의 양을 제어. 0 ~ 1 사이 값으로 설정. 0에 가까울 수록 탄력 있는 애니메이션을 만들고, 1에 가까울 수록 뻣뻣해보이는 효과를 만든다. 이 값은 스프링의 강성(stiffness)으로 생각할 수 있다.
            // initialSpringVelocity: 애니메이션의 초기 속도를 제어. 1은 1초 동안 전체 거리를 커버하도록 애니메이션의 초기 속도를 설정. 값이 크거나 작을 수록 애니메이션의 속도가 더 크거나 작아지고, 스프링이 안정되는 방식에 영향을 미친다. 그러나 초기 속도는 스프링 계산에 의해 곧 수정되며, 애니메이션은 항상 duration의 끝에 종료된다.
          self.loginButton.center.y -= 30.0
          self.loginButton.alpha = 1.0
        }, completion: nil)
        
        // create new view
        let newView = UIImageView(image: UIImage(named: "banner"))
        newView.center = animationContainerView.center
        
        // 새로운 트랜지션을 생성한다. UIView.animate와 비슷하지만, 여기서는 매개변수로 컨테이너 역할을 하는 UIView를 필요로 한다.
        UIView.transition(with: animationContainerView,
                          duration: 0.5,
                          options: [.curveEaseOut, .transitionFlipFromBottom],
                          animations: {
            // transitionFlipFromBottom: 뷰의 아래쪽 가장자리로 뷰를 뒤집는다.
            self.animationContainerView.addSubview(newView)
        }, completion: nil)
        
        /* remove the view via transition
        UIView.transition(with: animationContainerView, duration: 0.33,
          options: [.curveEaseOut, .transitionFlipFromBottom],
          animations: {
            // 뒤집기 애니메이션을 수행하고, someView는 마지막에 제거된다.
            someView.removeFromSuperview()
          }, completion: nil)
        
        
        // hide the view via transition
        UIView.transition(with: someView, duration: 0.33,
                          options: [.curveEaseOut, .transitionFlipFromBottom],
                          animations: {
            someView.alpha = 0
        }, completion: { _ in
            //
            someView.isHidden = true
        })
        
        // replace via transition. 이거 수행하면 전체 뷰가 플립 되는 효과가 생김;;;;
        UIView.transition(from: password, to: username, duration: 0.33, options: .transitionFlipFromTop) */

        animateCloud(cloud1)
        animateCloud(cloud2)
        animateCloud(cloud3)
        animateCloud(cloud4)
    }
    
    // MARK: further methods

    @IBAction private func login() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
          self.loginButton.bounds.size.width += 80.0
        }, completion: { _ in
            self.showMessage(index: 0)
        })
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
          self.loginButton.center.y += 60.0
        }, completion: { _ in
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            
            self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height / 2)
            self.spinner.alpha = 1.0
        })
    }
    
    private func showMessage(index: Int) {
        statusLabel.text = statusMessages[index]
        
        UIView.transition(with: statusImageView, duration: 0.33,
                          options: [.curveEaseOut, .transitionCurlDown],
                          animations: {
            // transitionCurlDown: 종이를 뒤집는 것처럼 애니메이션을 만든다.
            self.statusImageView.isHidden = false
        }, completion: { _ in
            //transition completion
            delay(2.0) {
                if index < self.statusMessages.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    // reset form
                    self.resetForm()
                }
            }
        })
    }
    
    private func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [],
                       animations: {
            self.statusImageView.center.x += self.view.frame.size.width     // 화면 밖으로 빼낸다.
        }, completion: { _ in
            self.statusImageView.center = self.statusPosition   // 원래 위치로 옮기고 숨긴다.
            self.statusImageView.isHidden = true
            
            self.showMessage(index: index + 1)
        })
    }
    
    private func resetForm() {
        UIView.transition(with: statusImageView, duration: 0.2, options: .transitionFlipFromTop, animations: {
            // 상태표시 뷰를 다시 히든처리.
            self.statusImageView.isHidden = true
            self.statusImageView.center = self.statusPosition
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            // spinner 상태를 리셋시키고, 로그인 버튼의 위치와 색상을 초기화 한다.
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
        }, completion: nil)
    }
    
    private func animateCloud(_ cloud: UIImageView) {
        let cloudSpeed = 60.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
            // 구름이 화면 밖을 완전히 벗어날때까지 x축 양의 방향으로 서서히 이동시키는 애니메이션을 수행
            // curveLinear를 없애도 애니메이션 효과는 똑같은데, 구름이 화면 오른쪽을 완전히 벗어났을 때 왼쪽에서 바로 안 나타남.. 이유는 모르곘다.
            cloud.frame.origin.x = self.view.frame.size.width
        }, completion: { _ in
            // 구름이 화면 밖을 완전히 벗어나면, x좌표를 화면을 벗어난 시작지점으로 옮긴다
            cloud.frame.origin.x = -cloud.frame.size.width
            self.animateCloud(cloud)
        })
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
}
