import Analytics

class AnalyticsSerive {

    private let analyticsSerivce: Analytics.AnalyticsService

    init(analyticsSerivce: Analytics.AnalyticsService) {
        self.analyticsSerivce = analyticsSerivce
    }

    func send(_ event: iTravallerEvent) {
        analyticsSerivce.send(event)
    }
}
