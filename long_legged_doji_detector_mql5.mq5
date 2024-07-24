//+------------------------------------------------------------------+
//| Long-Legged Doji Detector Function                               |
//+------------------------------------------------------------------+
bool LongLeggedDoji(double open, double close, double high, double low){
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
        // If either the upper shadow of the lower shadow is less than 4 points, return false
        if (upperShadow < 4 * onePoint || lowerShadow < 4 * onePoint)
        {
            return (false);
        }
        // If there is less than 10 points in each shadow, branch
        if(upperShadow < 10 * onePoint || lowerShadow < 10 * onePoint){
            // If there is more than 1 point difference between the upper and lower shadows, return false
            if(MathAbs(upperShadow - lowerShadow) > onePoint){
                return(false);
            }else{
                return(true);
            }
        }
    }else{
        // If the body size is more than 5% of the total range, return false
        if(bodySize > 0.05 * (high - low)){
            return(false);
        }
        // If the upper shadow or lower shadow are less than 40% of the total range, return false
        if(upperShadow < 0.4 * (high - low) || lowerShadow < 0.4 * (high - low)){
            return(false);
        }
        // If there is more than 10% difference between the upper and lower shadows, return false
        if(MathAbs(upperShadow - lowerShadow) > 0.1 * (high - low)){
            return(false);
        }
        // Otherwise return true
        return(true);
    }
    return(true);
}
