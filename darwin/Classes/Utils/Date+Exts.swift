extension Date {
    var asInt64: Int64 { return Int64(self.timeIntervalSince1970) }
}
