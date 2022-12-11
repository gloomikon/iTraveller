public class AnalyticsService {

    public init() {

    }

    public func send(_ event: Event) {
        print("Sent event \(event.name) with params \(String(describing: event.params))")
    }
}
