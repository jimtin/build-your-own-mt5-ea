//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+


// Input parameters
input double candleSizeMultiplier = 1.5; // Bullish Engulfing Multiplier
input int downTrendPeriod = 2;           // Down Trend Period

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
//| Bullish Engulfing Candle                       
//| Investopedia Link: https://www.investopedia.com/terms/b/bullishengulfingpattern.asp |                  |
//+------------------------------------------------------------------+
bool BullishEngulfing(double lastOpen, double secondLastOpen, double lastClose, double secondLastClose){
    // Check that the last candle is bullish
    if(lastClose <= lastOpen){
        return(false);
    }
    // Check that the second last candle is bearish
    if(secondLastClose >= secondLastOpen){
        return(false);
    }
    // Check that the last candle engulfs the second last candle
    if(lastOpen < secondLastClose && lastClose > secondLastOpen){
        // Check that the size of the last candle is at least 50% larger than the second last candle
        if((lastClose - lastOpen) > candleSizeMultiplier * (secondLastClose - secondLastOpen)){
            return(true);
        }
    }
    // Return false
    return(false);
}


//+------------------------------------------------------------------+
//| Advanced Bullish Engulfing Detector                              |
//+------------------------------------------------------------------+
bool BullishEngulfingTurnaroundDetector(){
    // Add two to the down trend period
    int downTrendPeriodDetector = downTrendPeriod + 2;
    // Get the two previous candle data
    double lastOpen = iOpen(_Symbol, 0, 1);
    double lastClose = iClose(_Symbol, 0, 1);
    double secondLastOpen = iOpen(_Symbol, 0, 2);
    double secondLastClose = iClose(_Symbol, 0, 2);
    // Check if a bullish engulfing candle has formed
    if(BullishEngulfing(lastOpen, secondLastOpen, lastClose, secondLastClose)){
        // Check if the last down trend period candles are bearish
        for(int i = 2; i <= downTrendPeriodDetector; i++){
            double open = iOpen(_Symbol, 0, i);
            double close = iClose(_Symbol, 0, i);
            if(close >= open){
                return(false);
            }
        }
        return(true);
    }
    return(false);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");

    // Check if a bullish engulfing turnaround has formed
    if(BullishEngulfingTurnaroundDetector()){
        // Print a message
        Print("Bullish Engulfing Turnaround Detected!");
    }else{
        // Print a message
        Print("No Bullish Engulfing Turnaround Detected!");
    }
    
}
