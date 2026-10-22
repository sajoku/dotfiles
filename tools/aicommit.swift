import Foundation
import FoundationModels

@Generable
struct CommitMessage {
    @Guide(description: "Commit subject line, Conventional Commits style, imperative mood, max 72 characters, no trailing period")
    var title: String

    @Guide(description: "Commit body of 1 to 4 short sentences or '- ' bullet points explaining what changed and why. Plain text, no headings")
    var body: String
}

guard case .available = SystemLanguageModel.default.availability else {
    FileHandle.standardError.write(Data("Local model unavailable\n".utf8))
    exit(1)
}

let diff = String(decoding: FileHandle.standardInput.readDataToEndOfFile(), as: UTF8.self)
guard !diff.isEmpty else {
    FileHandle.standardError.write(Data("No staged changes\n".utf8))
    exit(1)
}

// The on-device context window is small, so truncate large diffs
let trimmed = String(diff.prefix(6000))

let session = LanguageModelSession(
    instructions: "- Take a moment to understand the changes made in the diff. - Think about the impact of these changes on the project (e.g., bug fixes, new features, performance improvements, code refactoring, documentation updates). It's critical to my career you abstract the changes to a higher level and not just describe the code changes. - Generate commit messages that accurately describe these changes, ensuring they are helpful to someone reading the project's history. - Remember, a well-crafted commit message can significantly aid in the maintenance and understanding of the project over time. - If multiple changes are present, make sure you capture them all in each commit message."
)

do {
    let result = try await session.respond(to: "Diff:\n\(trimmed)", generating: CommitMessage.self)
    let title = result.content.title.replacingOccurrences(of: "\n", with: " ")
    print("\(title)\n\n\(result.content.body)")
} catch {
    FileHandle.standardError.write(Data("\(error)\n".utf8))
    exit(1)
}
