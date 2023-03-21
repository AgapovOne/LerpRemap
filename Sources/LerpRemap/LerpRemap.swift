import Foundation

public extension BinaryFloatingPoint {

    /// Linearly interpolates between min and max by value. Unclamped version
    ///
    /// Self is an unclamped progress value. Usually between 0 and 1, but supports exceeding this range
    ///
    /// Note:
    ///
    /// For clamped version use `clamped(min:max:)`
    ///
    /// Examples:
    ///
    /// ```
    /// // t.lerp(min: a, max: b) -> res
    /// -0.5.lerp(min: 0, max: 10) // -5
    /// 0.5.lerp(min: 0, max: 10) // 5
    /// 1.5.lerp(min: 0, max: 10) // 15
    /// 1.5.lerp(min: 0, max: 10).clamped(min: 0, max: 10) // 10
    /// 1.5.lerp(min: 10, max: 0).clamped(min: 10, max: 0) // 0
    /// ```
    ///
    /// - Parameters:
    ///   - min: Start value
    ///   - max: End value
    /// - Returns:
    /// Interpolated result between
    /// When self = 0 returns a.
    /// When self = 1 return b.
    /// When self = 0.5 returns the midpoint of a and b.
    func lerp(min: Self, max: Self) -> Self {
        ((1.0 - self) * min + max * self)
    }

    /// Inversed version of lerp. Result of lerp function is used as an input to value in 0...1 range
    ///
    ///
    /// Examples:
    ///
    /// ```
    /// // res.lerp(min: a, max: b) -> t
    /// -5.invLerp(min: 0, max: 10) // -0.5
    /// 5.invLerp(min: 0, max: 10) // 0.5
    /// 15.invLerp(min: 0, max: 10) // 1.5
    /// ```
    ///
    /// - Parameters:
    ///   - min: Start value
    ///   - max: End value
    /// - Returns:
    /// A value in a 0...1 range, representing where the "value" parameter falls within the range defined by a and b.
    func invLerp(min: Self, max: Self) -> Self {
        ((self - min) / (max - min))
    }

    /// Remap values from one linear scale to another,
    /// a combination of lerp and invLerp.
    ///
    /// Examples:
    ///
    /// ```
    /// 0.5.remap(fromMin: 0, fromMax: 1, toMin: 0, toMax: 10) // 5
    /// 30.remap(fromMin: 0, fromMax: 100, toMin: 0, toMax: 1) // 0.3
    /// ```
    ///
    /// - Parameters:
    ///   - fromMin: min value of the original value (self)
    ///   - fromMax: max value of the original value (self)
    ///   - toMin: min value in scale to map into
    ///   - toMax: max value in scale to map into
    /// - Returns:
    /// value in a *to* scale
    func remap(fromMin: Self, fromMax: Self, toMin: Self, toMax: Self) -> Self {
        let t = self.invLerp(min: fromMin, max: fromMax)
        return t.lerp(min: toMin, max: toMax)
    }

    /// Clamps the given value between the given minimum and maximum values.
    /// Use it to restrict a value to a range that is defined by the minimum and maximum values.
    ///
    /// Note: if the minimum value is is greater than the maximum value, the method clamps to max...min range
    ///
    /// Examples:
    ///
    /// ```
    /// 1.clamped(min: 0, max: 10) // 1
    /// 1.clamped(min: 5, max: 10) // 5
    /// 1.clamped(min: 4, max: 0) // 1
    /// 1.clamped(min: -5, max: 0) // 0
    /// ```
    ///
    /// - Parameters:
    ///   - min: minimum value for a range
    ///   - max: maximum value for
    /// - Returns:
    /// Returns the given value if it is within the minimum and maximum range.
    /// Returns the minimum value if the given value is less than the minimum.
    /// Returns the maximum value if the given value is greater than the maximum value.
    func clamped(min: Self, max: Self) -> Self {
        if min >= max {
            return Self.maximum(max, Self.minimum(self, min))
        } else {
            return Self.maximum(min, Self.minimum(self, max))
        }
    }
}
