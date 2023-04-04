- transitionCrossDissolve 옵션을 통한 fade 효과 부여
- CGAffineTransform를 통한 3d 효과 부여
- CAEmitterLayer를 이용한 애니메이션 효과

class func animateKeyframes(withDuration duration: TimeInterval, delay: TimeInterval, options: UIView.KeyframeAnimationOptions = [], animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil)
- 특정한 프레임에서 시작점과 끝점을 지정하여 여러가지 효과를 적용하고자 할 때 사용
- animateKeyframes를 사용하면, 특정 애니메이션을 keyframe 형태로 추가해야 한다.

class func addKeyframe(withRelativeStartTime frameStartTime: Double, relativeDuration frameDuration: Double, animations: @escaping () -> Void)
- animateKeyframes의 duration에 대비하여 상대 지속시간을 사용
