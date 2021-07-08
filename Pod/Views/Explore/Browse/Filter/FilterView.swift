//
//  BrowseFilter.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var filter: BrowseFilter
    let exit: () -> Void
    
    init(
        _ filter: Binding<BrowseFilter>?,
        exit: @escaping () -> Void
    ) {
        self._filter = filter!
        self.exit = exit
    }
    
    @State var acidity: Int?
    @State var available: Bool?
    @State var bitterness: Int?
    @State var cup: String?
    @State var decaffeinated: Bool?
    @State var intensity: Int?
    @State var ratingBody: Int?
    @State var roasting: Int?
    
    private var active: Bool {
        acidity != nil ||
            available != nil ||
            bitterness != nil ||
            cup != nil ||
            decaffeinated != nil ||
            intensity != nil ||
            ratingBody != nil ||
            roasting != nil
    }
    
    private var isDirty: Bool {
        filter.acidity != acidity ||
            filter.available != available ||
            filter.bitterness != bitterness ||
            filter.body != ratingBody ||
            filter.cup != cup ||
            filter.decaffeinated != decaffeinated ||
            filter.intensity != intensity ||
            filter.roasting != roasting
    }
    
    private func log() {
        if active {
            Analytics.log(event: .filter, data: [
                Analytics.AnalyticsParameterAcidity: acidity as Any,
                Analytics.AnalyticsParameterBitterness: bitterness as Any,
                Analytics.AnalyticsParameterCapsuleAvailable: available as Any,
                Analytics.AnalyticsParameterCupSize: cup as Any,
                Analytics.AnalyticsParameterDecaffeinated: decaffeinated as Any,
                Analytics.AnalyticsParameterIntensity: intensity as Any,
                Analytics.AnalyticsParameterBody: ratingBody as Any,
                Analytics.AnalyticsParameterRoasting: roasting as Any
            ])
        }
    }
    
    private func setFilter() {
        filter = BrowseFilter([
            "acidity": acidity as Any,
            "available": available as Any,
            "bitterness": bitterness as Any,
            "body": body as Any,
            "cup": cup as Any,
            "decaffeinated": decaffeinated as Any,
            "intensity": intensity as Any,
            "roasting": roasting as Any
        ])
    }
    
    private func setState(clear: Bool = false) {
        acidity = clear ? nil : filter.acidity
        available = clear ? nil : filter.available
        bitterness = clear ? nil : filter.bitterness
        cup = clear ? nil : filter.cup
        decaffeinated = clear ? nil : filter.decaffeinated
        intensity = clear ? nil : filter.intensity
        ratingBody = clear ? nil : filter.body
        roasting = clear ? nil : filter.roasting
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { gp in
                ZStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            FilterIntensity(selected: $intensity) {
                                if active {
                                    Button(action: {
                                        setState(clear: true)
                                    }) {
                                        Text("Clear All").fontWeight(.regular)
                                    }
                                }
                            }
                            FilterCup(selected: $cup)
                            FilterDecaffeinated(selected: $decaffeinated)
                            FilterAvailable(selected: $available)
                            FilterRatingGroup(acidity: $acidity, bitterness: $bitterness, ratingBody: $ratingBody, roasting: $roasting)
                        }
                        .padding(.bottom, 120)
                    }
                    FilterActions(
                        gp: gp,
                        cancel: exit,
                        apply: {
                            setFilter()
                            log()
                            exit()
                        },
                        disabled: !isDirty
                    )
                }
                .background(Color("PrimaryBackground").edgesIgnoringSafeArea(.all))
            }
            .navigationBarTitle("Filter")
        }
        .onAppear {
            self.setState()
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Filter",
                Analytics.AnalyticsParameterScreenClass: "FilterView"
            ])
        }
    }
}
