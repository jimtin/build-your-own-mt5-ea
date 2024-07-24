//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Expert Initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(){
    // Print a series of = to delineate a new start
    Print("=====================================");
    // Print the EA name
    Print("EA from AppnologyJames. Hello World!");
    // Return value
    return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+
//| Expert Deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){
    // Print the EA name
    Print("EA from AppnologyJames. Goodbye World!");
    Print("Exit Reason: ", reason);
    // Print a series of = to delineate a new end
    Print("=====================================");
}

//+------------------------------------------------------------------+
//| Doji Star Detector Function                                      |
//+------------------------------------------------------------------+
bool DojiStar(double open, double close, double high, double low){
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


//+------------------------------------------------------------------+
//| Gravestone Doji Detector                                         |
//+------------------------------------------------------------------+
bool GravestoneDojiDetector(double open, double close, double high, double low){
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
        // If the lower shadow is 1 point or less, and the upper shadow is at least 4 points, return true
        if (lowerShadow <= onePoint && upperShadow >= 4 * onePoint)
        {
            return (true);
        }
        // If the lower shaow is 2 points, and upper shadow is at least 6 points, return true
        if (lowerShadow == 2 * onePoint && upperShadow >= 6 * onePoint)
        {
            return (true);
        }
        return(false);
    }else{
        // The upper shadow must be at least 4 times the size of the body
        if(upperShadow < 4 * bodySize){
            return(false);
        }
        // The lower shadow must be less than 10% of the total range
        if(lowerShadow > 0.1 * (high - low)){
            return(false);
        }
        // The body size must also be less than 5% of the total range
        if(bodySize > 0.05 * (high - low)){
            return(false);
        }
        // Otherwise return true
        return(true);
    }
    return(true);
}


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


//+------------------------------------------------------------------+
//| Doji Super Detector                                              |
//+------------------------------------------------------------------+
string DojiSuperDetector(int candles_previous){
    // Get the candle data
    double open = iOpen(_Symbol, 0, candles_previous);
    double close = iClose(_Symbol, 0, candles_previous);
    double high = iHigh(_Symbol, 0, candles_previous);
    double low = iLow(_Symbol, 0, candles_previous);

    // Check for a Doji Star
    if(DojiStar(open, close, high, low)){
        return("Doji Star");
    }
    // Check for a Long-Legged Doji
    if(LongLeggedDoji(open, close, high, low)){
        return("Long-Legged Doji");
    }
    // Check for a Gravestone Doji
    if(GravestoneDojiDetector(open, close, high, low)){
        return("Gravestone Doji");
    }
    // Check for a Dragonfly Doji
    if(DragonflyDojiDetector(open, close, high, low)){
        return("Dragonfly Doji");
    }
    // Return no Doji
    return("No Doji");

}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Print the Doji Super Detector
    Print("Doji Super Detector: ", DojiSuperDetector(1));
}
