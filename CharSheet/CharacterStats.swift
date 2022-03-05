struct CharacterStats {
    let strength: Int
    let constitution: Int
    let dexterity: Int
    let wisdom: Int
    let intelligence: Int
    let charisma: Int
}

extension CharacterStats {

    enum Label: String, RawRepresentable, CaseIterable {
        case Strength
        case Constitution
        case Dexterity
        case Wisdom
        case Intelligence
        case Charisma
    }
}
