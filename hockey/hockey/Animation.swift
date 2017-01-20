import SpriteKit

let π = Float(M_PI)

struct TimingFunctions
{
    static func Linear(t: Float) -> Float
    {
        return t
    }
    
    static func QuadraticEaseIn(t: Float) -> Float
    {
        return t * t
    }
    
    static func QuadraticEaseOut(t: Float) -> Float
    {
        return t * (2.0 - t)
    }
    
    static func QuadraticEaseInOut(t: Float) -> Float
    {
        if t < 0.5
        {
            return 2.0 * t * t
        }
        else
        {
            let f = t - 1.0
            return 1.0 - 2.0 * f * f
        }
    }
    
    static func CubicEaseIn(t: Float) -> Float
    {
        return t * t * t
    }
    
    static func CubicEaseOut(t: Float) -> Float
    {
        let f = t - 1.0
        return 1.0 + f * f * f
    }
    
    static func CubicEaseInOut(t: Float) -> Float
    {
        if t < 0.5
        {
            return 4.0 * t * t * t
        }
        else
        {
            let f = t - 1.0
            return 1.0 + 4.0 * f * f * f
        }
    }
    
    static func QuarticEaseIn(t: Float) -> Float
    {
        return t * t * t * t
    }
    
    static func QuarticEaseOut(t: Float) -> Float
    {
        let f = t - 1.0
        return 1.0 - f * f * f * f
    }
    
    static func QuarticEaseInOut(t: Float) -> Float
    {
        if t < 0.5
        {
            return 8.0 * t * t * t * t
        } else
        {
            let f = t - 1.0
            return 1.0 - 8.0 * f * f * f * f
        }
    }
    
    static func QuinticEaseIn(t: Float) -> Float
    {
        return t * t * t * t * t
    }
    
    static func QuinticEaseOut(t: Float) -> Float
    {
        let f = t - 1.0
        return 1.0 + f * f * f * f * f
    }
    
    static func QuinticEaseInOut(t: Float) -> Float
    {
        if t < 0.5
        {
            return 16.0 * t * t * t * t * t
        }
        else
        {
            let f = t - 1.0
            return 1.0 + 16.0 * f * f * f * f * f
        }
    }
    
    static func SineEaseIn(t: Float) -> Float
    {
        return sin((t - 1.0) * π/2) + 1.0
    }
    
    static func SineEaseOut(t: Float) -> Float
    {
        return sin(t * π/2)
    }
    
    static func SineEaseInOut(t: Float) -> Float
    {
        return 0.5 * (1.0 - cos(t * π))
    }
    
    static func CircularEaseIn(t: Float) -> Float
    {
        return 1.0 - sqrt(1.0 - t * t)
    }
    
    static func CircularEaseOut(t: Float) -> Float
    {
        return sqrt((2.0 - t) * t)
    }
    
    static func CircularEaseInOut(t: Float) -> Float
    {
        if t < 0.5
        {
            return 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
        }
        else
        {
            return 0.5 * sqrt(-4.0 * t * t + 8.0 * t - 3.0) + 0.5
        }
    }
    
    static func ExponentialEaseIn(t: Float) -> Float
    {
        return (t == 0.0) ? t : pow(2.0, 10.0 * (t - 1.0))
    }
    
    static func ExponentialEaseOut(t: Float) -> Float
    {
        return (t == 1.0) ? t : 1.0 - pow(2.0, -10.0 * t)
    }
    
    static func ExponentialEaseInOut(t: Float) -> Float
    {
        if t == 0.0 || t == 1.0
        {
            return t
        }
        else if t < 0.5
        {
            return 0.5 * pow(2.0, 20.0 * t - 10.0)
        }
        else
        {
            return 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0)
        }
    }
    
    
    static func SigmoidCurve(exponent:Int) -> (Float) -> Float
    {
        func base(t:Float) -> Float
        {
            return (1 / (1 + exp(Float(-exponent) * t))) - Float(0.5)
        }
        
        var correction:Float = 0.5 / base(t: 1);
        
        
        func sigmoid(t:Float) -> Float
        {
            return correction * base(t: 2 * t - 1) + 0.5
        }
        
        return sigmoid
    }
    
    static func Smoothstep(t: Float) -> Float
    {
        return t * t * (3 - 2 * t)
    }
    
    static func Smootherstep(t: Float) -> Float
    {
        return 6 * pow(t, 5) - 15 * pow(t, 4) + 10 * pow(t, 3)
    }
}





struct AnimationPoints
{
    static let topLeft      = CGPoint(x:         0, y:     HEIGHT)
    static let topCenter    = CGPoint(x: HALFWIDTH, y:     HEIGHT)
    static let topRight     = CGPoint(x:     WIDTH, y:     HEIGHT)
    
    static let centerLeft   = CGPoint(x:         0, y: HALFHEIGHT)
    static let centerCenter = CGPoint(x: HALFWIDTH, y: HALFHEIGHT)
    static let centerRight  = CGPoint(x:     WIDTH, y: HALFHEIGHT)
    
    static let bottomLeft   = CGPoint(x:         0, y:          0)
    static let bottomCenter = CGPoint(x: HALFWIDTH, y:          0)
    static let bottomRight  = CGPoint(x:     WIDTH, y:          0)
    
    
    static let centerBottom = CGPoint(x: HALFWIDTH, y:          0)
    static let centerTop    = CGPoint(x: HALFWIDTH, y:     HEIGHT)
    
    static let leftBottom   = CGPoint(x:         0, y:          0)
    static let leftCenter   = CGPoint(x:         0, y: HALFHEIGHT)
    static let leftTop      = CGPoint(x:         0, y:     HEIGHT)
    
    static let rightBottom  = CGPoint(x:     WIDTH, y:          0)
    static let rightCenter  = CGPoint(x:     WIDTH, y: HALFHEIGHT)
    static let rightTop     = CGPoint(x:     WIDTH, y:     HEIGHT)
    
    
    
    static func GetHalfWidth(of:SKNode) -> CGFloat
    {
        return of.frame.width / CGFloat(2)
    }
    
    static func GetHalfHeight(of:SKNode) -> CGFloat
    {
        return of.frame.height / CGFloat(2)
    }
}


class Animation
{
    enum `Type`
    {
        case NONE, Position, Scale, Alpha
    }
    
    var duration: TimeInterval
    var type: Type
    var event: Event
    
    init(event: Event, duration: TimeInterval)
    {
        self.event    = event
        self.duration = duration
        self.type = .NONE
    }
}

protocol Gettable
{
    func get(forEvent: Event) -> SKAction?
}



class Moveable : Animation, Gettable
{
    var endPosition: CGPoint

    init(event: Event, duration: TimeInterval, end: CGPoint)
    {
        endPosition = end
        
        super.init(event: event, duration: duration)
        type = .Position
    }
    
    func get(forEvent: Event) -> SKAction?
    {
        var animation: SKAction?
        
        if forEvent.type == event.type
        {
            animation = SKAction.move(to: endPosition, duration: duration)
        }
        
        return animation
    }
}



class Scaleable : Animation, Gettable
{
    var endScale: CGFloat
    
    init(event: Event, duration: TimeInterval, end: CGFloat)
    {
        endScale = end
        
        super.init(event: event, duration: duration)
        type = .Position

        
        endScale = end
    }
    
    func get(forEvent: Event) -> SKAction?
    {
        var animation: SKAction?
        
        if forEvent.type == event.type
        {
            animation = SKAction.scale(to: endScale, duration: duration)
        }
        
        return animation
    }
}



class Fadeable : Animation, Gettable
{
    var fadeIn: Bool
    
    init(event: Event, duration: TimeInterval, in: Bool)
    {
        fadeIn = `in`

        super.init(event: event, duration: duration)
        type = .Position

        
    }
    
    func get(forEvent: Event) -> SKAction?
    {
        var animation: SKAction?
        
        if forEvent.type == event.type
        {
            if fadeIn
            {
                animation = SKAction.fadeIn(withDuration: duration)
            }
            else
            {
                animation = SKAction.fadeOut(withDuration: duration)
            }
        }
        
        return animation
    }
}










