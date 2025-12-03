//
//  SceneDelegate.swift
//  QuizzAppUI
//
//  Created by Ives Murillo on 10/27/25.
//

import UIKit
import QuizApp_iOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let question1 = Question.singleAnswer("What's Ives nationality")
        let question2 = Question.multipleAnswer("What's Jorge nationality")
        let questions = [question1, question2]

        let option1 = "Canadian"
        let option2 = "Colombian"
        let option3 = "American"

        let option4 = "Nigerian"
        let option5 = "Spanish"
        let option6 = "American"

        let options1 = [option1, option2, option3]
        let options2 = [option4, option5, option6]

        let correctAnswers = [question1: [option3], question2: [option6]]

        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(
            questions: questions,
            options: [question1: options1, question2: options2],
            correctAnswers: correctAnswers
        )
        let router = NavigationControllerRouter(
            navigationController,
            factory: factory
        )



        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window

        game = startGame(
            questions: questions,
            router: router,
            correctAnswer: correctAnswers
        )
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

class ViewController: UIViewController {

}
