//+------------------------------------------------------------------+
//| Doji Star Detector Function                                      |
//+------------------------------------------------------------------+
bool DojiStarDetected(){
    // Get the open price
    double open = iOpen(_Symbol, _Period, 0);
    // Get the close price
    double close = iClose(_Symbol, _Period, 0);
    // Get the high price
    double high = iHigh(_Symbol, _Period, 0);
    // Get the low price
    double low = iLow(_Symbol, _Period, 0);

    // Calculate the body size
    double bodySize = MathAbs(close - open);

    // Set up some conditions
    bool isBodySmall = false;
    bool isUpperShadowSmall = false;
    bool isLowerShadowSmall = false;
    bool isLegsProportional = false;

    // Get the point size
    double onePoint = 1 * _Point;

    // Get the Upper Shadow size
    double upperShadow = high - MathMax(open, close);
    // Get the Lower Shadow size
    double lowerShadow = MathMin(open, close) - low;

    // If the body size is zerp
    if(bodySize == 0){
        isBodySmall = true;
        // If the upper or lower shadows are 0 points, return false
        if(upperShadow == 0 || lowerShadow == 0){
            return(false);
        }
        // If the upper shadow is less than 1 point and lower shadow is 1 point, return false
        if(upperShadow < onePoint && lowerShadow > onePoint){
            return(false);
        }
        // If the upper shadow is 1 point and lower shadow is less than 1 point, return false
        if(upperShadow > onePoint && lowerShadow < onePoint){
            return(false);
        }
        // If the upper shadow is 1 point and the lower shadow is 1 point, return true
        if(upperShadow == onePoint && lowerShadow == onePoint){
            return(true);
        }
        // If the upper shadow is 2 points and the lower shadow is 2 points, return true
        if(upperShadow == 2 * onePoint && lowerShadow == 2 * onePoint){
            return(true);
        }
        // If the upper shadow is 2 points and the lower shadow is 1 point, return true
        if(upperShadow == 2 * onePoint && lowerShadow == onePoint){
            return(true);
        }
        // If the upper shadow is 1 point and the lower shadow is 2 points, return true
        if(upperShadow == onePoint && lowerShadow == 2 * onePoint){
            return(true);
        }
        // If the upper shadow is 3 points and the lower shadow is 3 points, return true
        if(upperShadow == 3 * onePoint && lowerShadow == 3 * onePoint){
            return(true);
        }
        // If the upper shadow is 3 points and the lower shadow is 2 point, return true
        if(upperShadow == 3 * onePoint && lowerShadow == 2 * onePoint){
            return(true);
        }
        // If the upper shadow is 2 points and the lower shadow is 3 points, return true
        if(upperShadow == 2 * onePoint && lowerShadow == 3 * onePoint){
            return(true);
        }
    }else{
        // The body must be less than 5% of the total range
        if(bodySize > 0.05 * (high - low)){
            return(false);
        }
        // The upper and lower shadows to be at least 40% of the total range
        if(upperShadow < 0.4 * (high - low) || lowerShadow < 0.4 * (high - low)){
            return(false);
        }
        // There must be no more than 10% difference between the upper and lower shadows
        if(MathAbs(upperShadow - lowerShadow) > 0.1 * (high - low)){
            return(false);
        }

        // Otherwise return true
        return(true);
    }
    // Return true
    return(true);
}
