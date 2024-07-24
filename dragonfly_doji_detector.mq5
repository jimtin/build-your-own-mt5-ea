//+------------------------------------------------------------------+
//| Dragonfly Doji Detector                                          |
//+------------------------------------------------------------------+
bool DragonflyDojiDetector(double open, double close, double high, double low){
    // Calculate the body size
    double bodySize = MathAbs(close - open);
    // Upper Shadow
    double upperShadow = high - MathMax(open, close);
    // Lower Shadow
    double lowerShadow = MathMin(open, close) - low;
    // Point Size
    double onePoint = 1 * _Point;
    // If the body size is zero
    if (bodySize == 0)
    {
        // If the upper shadow is 1 point or less, and the lower shadow is at least 4 points, return true
        if (upperShadow <= onePoint && lowerShadow >= 4 * onePoint)
        {
            return (true);
        }
        // If the upper shadow is 2 points, and lower shadow is at least 6 points, return true
        if (upperShadow == 2 * onePoint && lowerShadow >= 6 * onePoint)
        {
            return (true);
        }
        return(false);
    }else{
        // The lower shadow must be at least 4 times the size of the body
        if(lowerShadow < 4 * bodySize){
            return(false);
        }
        // The upper shadow must be less than 10% of the total range
        if(upperShadow > 0.1 * (high - low)){
            return(false);
        }
        // The body size must also be less than 5% of the total range
        if(bodySize > 0.05 * (high - low)){
            return(false);
        }
        return(true);
    }
}
