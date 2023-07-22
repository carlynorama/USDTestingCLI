import Foundation
import ArgumentParser
import USDServiceProvider


@main
public struct USDTestingCLI:ParsableCommand {
    public static let configuration = CommandConfiguration(
        
        abstract: "A Swift command-line tool",
        version: "0.0.1",
        subcommands: [
            test.self,
        ],
        defaultSubcommand: test.self)
    
    public init() {}
    
    struct test:ParsableCommand {
        func run() throws {
            print(USDServiceProvider().whatsInMyBin())
            print(USDServiceProvider().echo("can you hear me?"))
        }
    }
}


