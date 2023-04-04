- 뷰에 적용되어 있는 오토레이아웃 탐색 방법

ex: titleLabel.superview?.constraints.forEach { constraint in
  if constraint.firstItem === titleLabel && 
    constraint.firstAttribute == .centerX {
    constraint.constant = isMenuOpen ? -100.0 : 0.0
    return
  }
}

- NSLayoutConstraint에 identifier을 지정하여 오토레이아웃 탐색 가능
- 오토레이아웃 + 애니메이션 적용시에는 superview에서 layoutIfNeeded를 호출할 것
