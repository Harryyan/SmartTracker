//
//  Category.swift
//  Category
//
//  Created by Harry Yan on 18/08/21.
//

import Foundation
import SwiftUI

struct CategoryExpense: Identifiable {
    var expenseInToal: Double
    let category: Category
    
    var id: String { "\(category)\(expenseInToal)" }
}

enum Category: Identifiable {
    var id: String {
        switch self {
        case .food: return FOOD
        case .donation: return DONATION
        case .entertainment: return ENTERTAINMENT
        case .health: return HEALTH
        case .shopping: return SHOPPING
        case .transportation: return TRANSPORTATION
        case .utilities: return UTILITIES
        case .other: return OTHER
        }
    }
    
    static var all: [Category] {
        return [.food(budget: BUDGET_FOOD),
                .donation(budget: BUDGET_DONATION),
                .entertainment(budget: BUDGET_ENTERTAINMENT),
                .health(budget: BUDGET_HEALTH),
                .shopping(budget: BUDGET_SHOPPING),
                .transportation(budget: BUDGET_TRANSPORTATION),
                .utilities(budget: BUDGET_UTILITIES),
                .other(budget: BUDGET_OTHER)]
    }
    
    case food(budget: Double = BUDGET_FOOD)
    case donation(budget: Double = BUDGET_DONATION)
    case entertainment(budget: Double = BUDGET_ENTERTAINMENT)
    case health(budget: Double = BUDGET_HEALTH)
    case shopping(budget: Double = BUDGET_SHOPPING)
    case transportation(budget: Double = BUDGET_TRANSPORTATION)
    case utilities(budget: Double = BUDGET_UTILITIES)
    case other(budget: Double = BUDGET_OTHER)
    
    var systemNameIcon: String {
        switch self {
        case .donation: return "heart.circle.fill"
        case .food: return "archivebox"
        case .entertainment: return "tv.music.note"
        case .health: return "staroflife"
        case .shopping: return "cart"
        case .transportation: return "car"
        case .utilities: return "bolt"
        case .other: return "tag"
        }
    }
    
    var color: Color {
        switch self {
        case .donation: return Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        case .food: return Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
        case .entertainment: return Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
        case .health: return Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        case .shopping: return Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
        case .transportation: return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        case .utilities: return Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        case .other: return Color(#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1))
        }
    }
    
    var budget: Double {
        switch self {
        case .food(let value), .donation(let value),
                .entertainment(let value), .health(let value),
                .shopping(let value), .transportation(let value),
                .utilities(let value), .other(let value):
            return value
        }
    }
}

extension Category {
    init(name: String) {
        if name == Category.food(budget: BUDGET_FOOD).id {
            self = Category.food(budget: BUDGET_FOOD)
        } else if name == Category.donation(budget: BUDGET_DONATION).id {
            self = Category.donation(budget: BUDGET_DONATION)
        } else if name == Category.entertainment(budget: BUDGET_ENTERTAINMENT).id {
            self = Category.entertainment(budget: BUDGET_ENTERTAINMENT)
        } else if name == Category.health(budget: BUDGET_HEALTH).id {
            self = Category.health(budget: BUDGET_HEALTH)
        } else if name == Category.shopping(budget: BUDGET_SHOPPING).id {
            self = Category.shopping(budget: BUDGET_SHOPPING)
        } else if name == Category.transportation(budget: BUDGET_TRANSPORTATION).id {
            self = Category.transportation(budget: BUDGET_TRANSPORTATION)
        } else if name == Category.utilities(budget: BUDGET_UTILITIES).id {
            self = Category.utilities(budget: BUDGET_UTILITIES)
        } else {
            self = Category.other(budget: BUDGET_OTHER)
        }
    }
}
