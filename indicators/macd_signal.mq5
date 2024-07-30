//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+

// Input parameters
input int fastEMA = 12; // Fast Period
input int slowEMA = 26; // Slow Period
input int signalSMA = 9; // Signal Period
input int numCandles = 3; // Number of Previous Candles to Retrieve

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
//| MACD Cross Indicator                                             |
//| Investopedia Link: https://www.investopedia.com/terms/m/macd.asp |
//+------------------------------------------------------------------+
double MACD(string valueType){
    // Create a buffer for the MACD
    double macdBuffer[];
    // Convert into an array
    ArraySetAsSeries(macdBuffer, true);
    // Create a handle for the MACD
    int macdHandle = iMACD(_Symbol, _Period, fastEMA, slowEMA, signalSMA, PRICE_CLOSE);
    // Check that the handle is valid
    if(macdHandle == INVALID_HANDLE){
        // Print an error message
        Print("Invalid MACD Handle");
        // Return false
        return(0.00);
    }
    // Add 1 to the number of candles
    int numCandlestoRetrieve = numCandles + 1;
    if(valueType == "Histogram"){
        // Copy the MACD buffer
        CopyBuffer(macdHandle, 0, 0, numCandlestoRetrieve, macdBuffer);
    }else if(valueType == "Signal"){
        // Copy the MACD buffer
        CopyBuffer(macdHandle, 1, 0, numCandlestoRetrieve, macdBuffer);
    }else{
        Print("Invalid MACD Value Type");
        return(0.00);
    }
    
    // Check that the MACD buffer is not empty
    if(macdBuffer[0] == EMPTY_VALUE){
        // Print an error message
        Print("Empty MACD Buffer");
        // Return false
        return(0.00);
    }
    // Return the MACD value
    return(macdBuffer[numCandles]);
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Check for a MACD Cross
    Print(MACD("Signal"));
}
