//
//  TransactionFormView.swift
//  TransactionFormView
//
//  Created by Harry Yan on 18/08/21.
//

import SwiftUI

struct TransactionFormView: View {
    var transaction: Transaction?
    
    @ObservedObject var presenter: TransactionFormPresenter
    @StateObject var viewModel: TransactionViewModel
    
    var title: String {
        transaction == nil ? ADD_TRANSACTION : EDIT_TRANSACTION
    }
    
    let currencyOptions = [
        DropdownOption(key: CURRENCY_NZD, val: CURRENCY_NZD),
        DropdownOption(key: CURRENCY_USD, val: CURRENCY_USD)
    ]
    
    let categoryOptions = [
        DropdownOption(key: Category.food(budget: 0).id, val: Category.food(budget: 0).id),
        DropdownOption(key: Category.donation(budget: 0).id, val: Category.donation(budget: 0).id),
        DropdownOption(key: Category.entertainment(budget: 0).id, val: Category.entertainment(budget: 0).id),
        DropdownOption(key: Category.health(budget: 0).id, val: Category.health(budget: 0).id),
        DropdownOption(key: Category.shopping(budget: 0).id, val: Category.shopping(budget: 0).id),
        DropdownOption(key: Category.transportation(budget: 0).id, val: Category.transportation(budget: 0).id),
        DropdownOption(key: Category.utilities(budget: 0).id, val: Category.utilities(budget: 0).id),
        DropdownOption(key: Category.other(budget: 0).id, val: Category.other(budget: 0).id)
    ]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            TextField(TITLE, text: $viewModel.title)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                            
                            TextField(AMOUNT, value: $viewModel.amount, formatter: DateUtils.numberFormatter)
                                .modifier(InterFont(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4).keyboardType(.decimalPad)
                            
                            // Show Currency
                            DropdownButton(shouldShowDropdown: $viewModel.showCurrencyDrop, displayText: $viewModel.currencyName,
                                           options: currencyOptions, mainColor: Color.text_primary_color,
                                           backgroundColor: Color.secondary_color, cornerRadius: 4, buttonHeight: 50) { key in
                                let selectedObj = currencyOptions.filter({ $0.key == key }).first
                                if let object = selectedObj {
                                    viewModel.currencyName = object.val
                                    viewModel.selectedCurrency = key
                                }
                                
                                viewModel.showCurrencyDrop = false
                            }
                            
                            // Show Categories
                            DropdownButton(shouldShowDropdown: $viewModel.showCategoryDrop, displayText: $viewModel.categoryName,
                                           options: categoryOptions, mainColor: Color.text_primary_color,
                                           backgroundColor: Color.secondary_color, cornerRadius: 4, buttonHeight: 50) { key in
                                let selectedObj = categoryOptions.filter({ $0.key == key }).first
                                if let object = selectedObj {
                                    viewModel.categoryName = object.val
                                    viewModel.selectedCategory = key
                                }
                                
                                viewModel.showCategoryDrop = false
                            }
                            
                            HStack {
                                DatePicker(PICKERVIEW, selection: $viewModel.occuredOn,
                                           displayedComponents: [.date, .hourAndMinute]).labelsHidden().padding(.leading, 16)
                                Spacer()
                            }
                            .frame(height: 50).frame(maxWidth: .infinity)
                            .accentColor(Color.text_primary_color)
                            .background(Color.secondary_color).cornerRadius(4)
                        }
                        .frame(maxWidth: .infinity).padding(.horizontal, 8)
                        .alert(isPresented: $presenter.showAlert,
                               content: { Alert(title: Text(APP_NAME), message: Text(presenter.alertMsg), dismissButton: .default(Text("OK"))) })
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text(CANCEL)},
                trailing: Button(action: self.onSaveTapped) { Text(SAVE)}
            ).navigationBarTitle(title)
        }
    }
    
    private func onCancelTapped() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped() {
        presenter.save(transaction: transaction, transactionViewModel: viewModel)
        
        guard !presenter.showAlert else {
            return
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
