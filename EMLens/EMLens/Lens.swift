public struct Lens<Container, View> {
    public let get: (Container) -> View
    public let set: (View, Container) -> Container
}

precedencegroup ComposePrecedence {
    associativity: left
}

infix operator >>> : ComposePrecedence

func >>> <Container, View, Subview>(lhs: Lens<Container, View>, rhs: Lens<View, Subview>) -> Lens<Container, Subview> {
    return Lens(get: { rhs.get(lhs.get($0)) },
                set: { (c, a) in return lhs.set(rhs.set(c, lhs.get(a)), a) }
    )
}
