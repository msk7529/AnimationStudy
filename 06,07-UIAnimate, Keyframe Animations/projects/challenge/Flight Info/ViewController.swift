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
func delay(seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

final class ViewController: UIViewController {
    
    enum AnimationDirection: Int {
        case positive = 1
        case negative = -1
    }
    
    @IBOutlet var bgImageView: UIImageView!
    
    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var flightNr: UILabel!
    @IBOutlet var gateNr: UILabel!
    @IBOutlet var departingFrom: UILabel!
    @IBOutlet var arrivingTo: UILabel!
    @IBOutlet var planeImage: UIImageView!
    
    @IBOutlet var flightStatus: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    
    private let snowView = SnowView(frame: CGRect(x: -150, y: -100, width: 300, height: 50))
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust ui
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height / 2
        
        //add the snow effect layer
        let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlight(to: londonToParis)     // 처음에는 fade 효과를 주지 않음
    }
    
    // MARK: custom methods
    
    func changeFlight(to data: FlightData, animated: Bool = false) {
        // populate the UI with the next flight's data
        summary.text = data.summary
        
        if animated {
            // 배경 이미지뷰의 fade 효과 부여
            fade(imageView: bgImageView,
                 toImage: UIImage(named: data.weatherImageName)!,
                 showEffects: data.showWeatherEffects)
            
            // flight, gate 영역의 label에 3d 트랜지션 효과 부여
            let direction: AnimationDirection = data.isTakingOff ? .positive : .negative
            
            cubeTransition(label: flightNr, text: data.flightNr, direction: direction)
            cubeTransition(label: gateNr, text: data.gateNr, direction: direction)
            
            // 출발지와 도착지 label에 fade, bounce 효과 부여
            let offsetDeparting = CGPoint(x: CGFloat(direction.rawValue * 80), y: 0.0)
            moveLabel(label: departingFrom, text: data.departingFrom, offset: offsetDeparting)
            
            let offsetArriving = CGPoint(x: 0.0, y: CGFloat(direction.rawValue * 50))
            moveLabel(label: arrivingTo, text: data.arrivingTo, offset: offsetArriving)
            
            // 최하단 label에 3d 트랜지션 효과 부여
            cubeTransition(label: flightStatus, text: data.flightStatus, direction: direction)
            
            // 비행기에 keyframe 애니메이션 부여
            planeDepart()
            
            // 최상단 summary label에 keyframe 애니메이션 부여
            summarySwitch(to: data.summary)
        } else {
            bgImageView.image = UIImage(named: data.weatherImageName)
            snowView.isHidden = !data.showWeatherEffects
            
            flightNr.text = data.flightNr
            gateNr.text = data.gateNr
            departingFrom.text = data.departingFrom
            arrivingTo.text = data.arrivingTo
            flightStatus.text = data.flightStatus
        }
        
        // schedule next flight
        delay(seconds: 3.0) {
            // 이 때 부턴 fade 효과를 부여
            self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    
    func fade(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
        // 배경이미지 crossfading animation
        // 그냥 이미지를 페이드아웃 했다가 페이드인하면 이상하게 보임
        // imageView: 페이드아웃할 이미지뷰
        // toImage: 애니메이션이 끝날 때 표시하려는 새 이미지
        UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            imageView.image = toImage
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.snowView.alpha = showEffects ? 1.0 : 0.0
        }, completion: nil)
    }
    
    func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        // label: 애니메이션을 적용하려는 label
        
        // label의 모든 주요 속성을 복사하여 임시 label에 넣어준다.
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text    // 텍스트만 대체할 문자열로 넣어준다.
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = label.backgroundColor
        
        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset)
            .scaledBy(x: 1.0, y: 0.1)   // Y축에서만 텍스트의 크기를 조정하여 가장자리에서 텍스트 평면으로 보는 것처럼 찌그러뜨린다.
        
        label.superview?.addSubview(auxLabel)
        
        // 기존 label과 임시 label의 transform 방향과 포지션은 반대로 부여
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            auxLabel.transform = .identity  // 원본 크기로 되돌린다.
            label.transform = CGAffineTransform(translationX: 0.0, y: -auxLabelOffset)
                .scaledBy(x: 1.0, y: 0.1)
        }, completion: { _ in
            label.text = auxLabel.text
            label.transform = .identity
            
            auxLabel.removeFromSuperview()  // 애니메이션이 끝나면 임시 label은 제거
        })
    }
    
    func moveLabel(label: UILabel, text: String, offset: CGPoint) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = .clear
        
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseIn, animations: {
            auxLabel.transform = .identity
            auxLabel.alpha = 1.0
        }, completion: {_ in
            // clean up
            auxLabel.removeFromSuperview()
            label.text = text
            label.alpha = 1.0
            label.transform = .identity
        })
    }
    
    func planeDepart() {
        let originalCenter = planeImage.center
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, animations: {
            // animateKeyframes은 특정한 프레임에서 시작점과 끝점을 지정하여 여러가지 효과를 적용하고자 할 때 사용한다.
            // animateKeyframes을 사용하면, 특정 애니메이션을 keyframe 형태로 추가해야 한다.
            
            // add keyframes > 상대 지속시간을 사용
            // withRelativeStartTime: animateKeyframes withDuration의 0.0배 후, 즉 1.5초 * 0.0 > 0초 후에 시작한다.
            // relativeDuration: animateKeyframes withDuration의 0.25배 동안, 즉 1.5초 * 0.25 > 0.375 동안 재생된다.
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.planeImage.center.x += 80.0
                self.planeImage.center.y -= 10.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.planeImage.center.x += 100.0
                self.planeImage.center.y -= 50.0
                self.planeImage.alpha = 0.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                self.planeImage.transform = .identity
                self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                self.planeImage.alpha = 1.0
                self.planeImage.center = originalCenter     // 원래 위치로 되돌린다.
            }
        }, completion: nil)
    }
    
    func summarySwitch(to summaryText: String) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.45) {
                self.summary.center.y -= 100.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.45) {
                self.summary.center.y += 100.0
            }
        }, completion: nil)
        
        delay(seconds: 0.5) {
            self.summary.text = summaryText
        }
    }
}
