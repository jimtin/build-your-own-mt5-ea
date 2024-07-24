//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+


// Inputs
input int EMA_Period = 14;

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
//| Exponential Moving Average Indicator                             |
//+------------------------------------------------------------------+
double EMA(int candles_previous){
    // Create the buffer for the indicator
    double emaBuffer[];
    // Convert into an array
    ArraySetAsSeries(emaBuffer, true);
    // Get the handle for the indicator
    int emaHandle = iMA(_Symbol, 0, EMA_Period, candles_previous, MODE_EMA, PRICE_CLOSE);
    // If the handle is invalid, return 0
    if(emaHandle == INVALID_HANDLE){
        return 0;
    }
    // Copy the indicator data into the buffer
    int emaCopy = CopyBuffer(emaHandle, 0, 0, candles_previous + 1, emaBuffer);
    // If the copy failed, return 0
    if(emaCopy == 0){
        return 0;
    }
    // Return the EMA value
    return(emaBuffer[candles_previous]);
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Print the EMA value
    Print("EMA: ", EMA(0));
}
