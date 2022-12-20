class func animate(withDuration duration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions = [], animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil)

- delay: 애니메이션을 시작하기 전에 UIKit이 대기하는 시간(초)
- options:
            // repeat: 애니메이션이 영원히 반복됨
            // autoreverse: repeat와 함께 쓰면 정방향 역방향 애니메이션이 영원히 반복되며, 이것만 쓰면 한 번만 실행됨.
            // curveLinear: 애니메이션에 가속, 감속을 적용하지 않음
            // curveEaseIn: 애니메이션의 시작 부분에 가속 적용
            // curveEaseOut: 애니메이션의 끝 부분에 감속 적용
            // curveEaseInOut: 애니메이션 시작 시 가속을 하고, 종료 시 감속을 적용 > 가장 자연스러운 옵션
