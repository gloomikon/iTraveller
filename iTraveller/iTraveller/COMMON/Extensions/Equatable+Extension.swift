extension Equatable {
    func isOne(of items: Self...) -> Bool {
        items.contains(self)
    }

    func except(of items: Self...) -> Bool {
        !items.contains(self)
    }

    func isOne(of items: AnyClass...) -> Bool {
        items.contains(where: { type(of: self) == $0 })
    }
}
