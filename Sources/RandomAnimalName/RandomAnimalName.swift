import Foundation

func groupByFirstLetter(wordCollection: [String]) -> [Character: [String]] {
    return wordCollection.reduce(into: [:]) { result, word in
        let firstLetter = word.first ?? Character(" ")
        result[firstLetter, default: []].append(word)
    }
}

private func findCommonLetters(lettersA: [String], lettersB: [String]) -> [String] {
    return lettersA.reduce(into: []) { result, letter in
        if lettersB.contains(letter) {
            result.append(letter)
        }
    }
}

private func loadJson(filename fileName: String) -> [String]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([String].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

private let adjectives = groupByFirstLetter(wordCollection: loadJson(filename: "adjectives") ?? [""])
private let animals = groupByFirstLetter(wordCollection: loadJson(filename: "animals") ?? [""])
private let possibleLetters = findCommonLetters(lettersA: Array(adjectives.keys).map {String($0)},
                                                lettersB: Array(animals.keys).map {String($0)})

private func randomAdjective(startLetter: Character) -> String {
    return adjectives[startLetter]?.randomElement() ?? "happy"
}

private func randomAnimal(startLetter: Character) -> String {
    let choice = animals[startLetter]?.randomElement() ?? "humunculous"
    return choice.split(separator: " ").joined(separator: "-")
}

public func randomAnimalName() -> String{
    let letter = possibleLetters.randomElement() ?? "h"
    let adjective = randomAdjective(startLetter: Character(letter))
    let animal = randomAnimal(startLetter: Character(letter))
    return "\(adjective) \(animal)".capitalized
}


