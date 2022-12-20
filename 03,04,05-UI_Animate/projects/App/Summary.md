**class func animate**(withDuration duration: TimeInterval, **delay**: TimeInterval, **options**: UIView.AnimationOptions = [], animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil)

- delay: 애니메이션을 시작하기 전에 UIKit이 대기하는 시간(초)
- repeat: 애니메이션이 영원히 반복됨

```autoreverse: repeat와 함께 쓰면 정방향 역방향 애니메이션이 영원히 반복되며, 이것만 쓰면 한 번만 실행됨.
curveLinear: 애니메이션에 가속, 감속을 적용하지 않음
curveEaseIn: 애니메이션의 시작 부분에 가속 적용
curveEaseOut: 애니메이션의 끝 부분에 감속 적용
curveEaseInOut: 애니메이션 시작 시 가속을 하고, 종료 시 감속을 적용 > 가장 자연스러운 옵션
```

**class func animate**(withDuration duration: TimeInterval, delay: TimeInterval, **usingSpringWithDamping** dampingRatio: CGFloat, **initialSpringVelocity** velocity: CGFloat, options: UIView.AnimationOptions = [], animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil)

- usingSpringWithDamping: 애니메이션이 최종 상태에 가까워질 때 애니메이션에 적용되는 감쇠(damping) 또는 감소(reduction)의 양을 제어. 0 ~ 1 사이 값으로 설정. 0에 가까울 수록 탄력 있는 애니메이션을 만들고, 1에 가까울 수록 뻣뻣해보이는 효과를 만든다. 이 값은 스프링의 강성(stiffness)으로 생각할 수 있다.
- initialSpringVelocity: 애니메이션의 초기 속도를 제어. 1은 1초 동안 전체 거리를 커버하도록 애니메이션의 초기 속도를 설정. 값이 크거나 작을 수록 애니메이션의 속도가 더 크거나 작아지고, 스프링이 안정되는 방식에 영향을 미친다. 그러나 초기 속도는 스프링 계산에 의해 곧 수정되며, 애니메이션은 항상 duration의 끝에 종료된다.
- transitionFlipFromBottom: 뷰의 아래쪽 가장자리로 뷰를 뒤집는다.
- transitionCurlDown: 종이를 뒤집는 것처럼 애니메이션을 만든다.

class func transition(with view: UIView, duration: TimeInterval, options: UIView.AnimationOptions = [], animations: (() -> Void)?, completion: ((Bool) -> Void)? = nil)

- 새로운 트랜지션을 생성한다. UIView.animated와 비슷하지만, 여기서는 변화를 주고 싶은 뷰를 매개변수로 필요로 한다.
- 뷰 계층 구조에서 뷰를 추가, 제거 및 교체하는 것을 목표로 한다.

class func transition(from fromView: UIView, to toView: UIView, duration: TimeInterval, options: UIView.AnimationOptions = [], completion: ((Bool) -> Void)? = nil)

- 트랜지션을 통해 뷰를 대체한다. 이거 수행하면 전체 뷰가 플립 되는 효과가 있을 수 있으니 주의
