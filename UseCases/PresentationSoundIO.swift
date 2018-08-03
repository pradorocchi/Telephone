//
//  PresentationSoundIO.swift
//  Telephone
//
//  Copyright © 2008-2016 Alexey Kuznetsov
//  Copyright © 2016-2018 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import Domain
import Foundation

final class PresentationSoundIO: NSObject {
    let input: PresentationAudioDevice
    let output: PresentationAudioDevice
    let ringtoneOutput: PresentationAudioDevice

    init(input: PresentationAudioDevice, output: PresentationAudioDevice, ringtoneOutput: PresentationAudioDevice) {
        self.input = input
        self.output = output
        self.ringtoneOutput = ringtoneOutput
    }
}

extension PresentationSoundIO {
    convenience init(soundIO: SystemDefaultingSoundIO, systemDefaultDeviceName name: String) {
        self.init(
            input: PresentationAudioDevice(item: soundIO.input, systemDefaultDeviceName: name),
            output: PresentationAudioDevice(item: soundIO.output, systemDefaultDeviceName: name),
            ringtoneOutput: PresentationAudioDevice(item: soundIO.ringtoneOutput, systemDefaultDeviceName: name)
        )
    }
}

extension PresentationSoundIO {
    override func isEqual(_ object: Any?) -> Bool {
        guard let soundIO = object as? PresentationSoundIO else { return false }
        return isEqual(to: soundIO)
    }

    override var hash: Int {
        return input.hash ^ output.hash ^ ringtoneOutput.hash
    }

    private func isEqual(to soundIO: PresentationSoundIO) -> Bool {
        return input == soundIO.input && output == soundIO.output && ringtoneOutput == soundIO.ringtoneOutput
    }
}
