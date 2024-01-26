//
//  EditReadingCardsView.swift
//  TarotTool
//
//  Created by Halcyone Rapp on 1/22/24.
//

import SwiftData
import SwiftUI


struct EditReadingCardsView: View {
//    @Bindable var reading: Reading

//    @Query(sort: [
//        SortDescriptor(\Card.name)
//    ]) var cards: [Card]
    
    var body: some View {
        Text("Hi cards")
//        Form {
//            List {
//                ForEach(cards, id: \.self) { card in
//                    Button(action: { cardSelect(card: card) }) {
//                        HStack {
//                            Image(systemName: "checkmark")
//                                .opacity(reading.cards!.contains(card) ? 1.0 : 0.0)
//                            Text(card.name)
//                        }
//                    }
//                }
//            }
//        }
    }
    
//    func cardSelect(card: Card) {
//        // force unwraping should be safe here, do i need/want more checks?
//        if reading.cards!.contains(card)  {
//            reading.cards?.removeAll(where: { $0 == card })
//        } else {
//            reading.cards!.append(card)
//        }
//    }

}




//struct EditReadingCardsView: View {
//    @Bindable var reading: Reading
//    //@Bindable var card: Card
//    
//    @State private var newCard: Bool = true
//    
//    var body: some View {
//        
//        ChooseCardsView(reading: reading)
//        
////        if newCard {
////            EditCardView(card: Card(name: "", details: "", notes: "", readings: [reading]))
////                .toolbar {
////                    Button("Choose cards", action: { newCard.toggle() })
////                }
////        } else {
////            ChooseCardsView(reading: reading)
////                .toolbar {
////                    Button("Add new card", action: { newCard.toggle() })
////                }
////        }
//    }
//}

//#Preview {
//    EditReadingCardsView()
//}
