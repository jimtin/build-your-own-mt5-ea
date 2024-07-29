//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+


// Input parameters
input double candleSizeMultiplier = 1.5; // Bullish Engulfing Multiplier

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
//| Bullish Engulfing Candle                                         |
//| Investopedia Link: https://www.investopedia.com/terms/b/bearishengulfingp.asp |
//+------------------------------------------------------------------+
bool BearishEngulfing(double lastOpen, double secondLastOpen, double lastClose, double secondLastClose){
    // Check that the last candle is bearish
    if(lastClose >= lastOpen){
        return(false);
    }
    // Check that the second last candle is bullish
    if(secondLastClose <= secondLastOpen){
        return(false);
    }
    // Check that the last candle engulfs the second last candle
    if(lastOpen > secondLastClose && lastClose < secondLastOpen){
        // Check that the size of the last candle is at least 50% larger than the second last candle
        if((lastOpen - lastClose) > candleSizeMultiplier * (secondLastClose - secondLastOpen)){
            return(true);
        }
    }
    // Return false
    return(false);
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");

    // Get the previous candle data
    double lastOpen = iOpen(_Symbol, 0, 1);
    double lastClose = iClose(_Symbol, 0, 1);
    // Get the second last candle data
    double secondLastOpen = iOpen(_Symbol, 0, 2);
    double secondLastClose = iClose(_Symbol, 0, 2);
    // Check if a bullish engulfing candle has formed
    if(BearishEngulfing(lastOpen, secondLastOpen, lastClose, secondLastClose)){
        // Print a message
        Print("Bearish Engulfing Candle Detected!");
    }else{
        // Print a message
        Print("No Bearish Engulfing Candle Detected!");
    }
    
}
