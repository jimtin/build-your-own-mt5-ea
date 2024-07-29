//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+

// Input parameters
input int fastEMA = 12; // Fast Period
input int slowEMA = 26; // Slow Period
input int signalSMA = 9; // Signal Period

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
string MACDSignalZeroCross(){
    // Create a buffer for the MACD
    double macdBuffer[];
    // Convert into an array
    ArraySetAsSeries(macdBuffer, true);
    // Create a buffer for the Signal Line
    double signalBuffer[];
    // Convert into an array
    ArraySetAsSeries(signalBuffer, true);
    // Create a buffer for the Histogram
    double histogramBuffer[];
    // Convert into an array
    ArraySetAsSeries(histogramBuffer, true);
    // Create a handle for the MACD
    int macdHandle = iMACD(_Symbol, _Period, fastEMA, slowEMA, signalSMA, PRICE_CLOSE);
    // Check that the handle is valid
    if(macdHandle == INVALID_HANDLE){
        // Print an error message
        Print("Invalid MACD Handle");
        // Return false
        return(false);
    }
    // Copy the MACD buffer
    CopyBuffer(macdHandle, 1, 0, 3, macdBuffer);
    double previousMACDSignal = macdBuffer[1];
    double secondPreviousMACDSignal = macdBuffer[2];
    // Check if the second previous MACD signal is below zero
    if(secondPreviousMACDSignal < 0){
        // Check if the previous MACD signal is above zero
        if(previousMACDSignal > 0){
            // Print a message
            Print("MACD Signal Line Crossed Above Zero");
            return("AboveZero");
        }
        // Return NoCross
        return("NoCross");
    }
    // Check if the second previous MACD signal is above zero
    if(secondPreviousMACDSignal > 0){
        // Check if the previous MACD signal is below zero
        if(previousMACDSignal < 0){
            // Print a message
            Print("MACD Signal Line Crossed Below Zero");
            return("BelowZero");
        }
        // Return NoCross
        return("NoCross");
    }
    // Return NoCross
    return("NoCross");
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Check for a MACD Cross
    MACDSignalZeroCross();
}
