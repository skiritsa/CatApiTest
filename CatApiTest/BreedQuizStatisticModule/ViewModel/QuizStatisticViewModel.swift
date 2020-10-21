//
//  QuizStatisticViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit
import CoreData

class QuizStatisticViewModel: QuizStatisticViewModelType {

    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getStatistic() -> QuizStatistic? {
        let fetchRequest: NSFetchRequest<QuizStatistic> = QuizStatistic.fetchRequest()
        do {
            let statistic = try context.fetch(fetchRequest)
            if statistic.isEmpty {
                let statistic = QuizStatistic(context: context)
                statistic.totalPlayed = 0
                statistic.winning = 0
                try context.save()
                print("new statistic")
                return statistic
            } else {
                return statistic.first
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }

    func resetStatistic() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: QuizStatistic.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            try appDelegate?.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}
