public class AnalyticsService {

    public init() {

    }

    public func send(_ event: Event) {
        print(event.name, event.params)
    }
}
