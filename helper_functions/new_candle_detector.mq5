//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+


// Global Variables

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
//| New Candle Detector                                              |
//+------------------------------------------------------------------+
bool NewCandle(){
    static datetime lastTime = 0;
    datetime currentTime = iTime(_Symbol, 0, 0);
    if(currentTime != lastTime){
        lastTime = currentTime;
        return true;
    }
    return false;
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Check for a new Candle
    if(NewCandle()){
        // Print the EA name
        Print("EA from AppnologyJames. New Candle!");
    }
}
