//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+

input int bollingerPeriod = 20;         // Bollinger Period
input double bollingerDeviation = 2.0;  // Bollinger Deviation
input int numCandles = 0;               // Number of Previous Candles to Retrieve

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
//| Bollinger Bands Indicator                                        |
//| Investopedia Link: https://www.investopedia.com/terms/b/bollingerbands.asp |
//+------------------------------------------------------------------+
double BollingerBands(string band){
    // Create a buffer for the Bollinger Bands
    double bollingerBuffer[];
    // Convert into an array
    ArraySetAsSeries(bollingerBuffer, true);
    // Create a handle for the Bollinger Bands
    int bollingerHandle = iBands(_Symbol, _Period, bollingerPeriod, numCandles, bollingerDeviation, PRICE_CLOSE);
    // Check that the handle is valid
    if(bollingerHandle == INVALID_HANDLE){
        // Print an error message
        Print("Invalid Bollinger Bands Handle");
        // Return false
        return(0.00);
    }
    // Add 1 to the number of candles
    int numCandlestoRetrieve = numCandles + 1;
    if(band == "Middle"){
        // Copy the Bollinger Bands buffer
        CopyBuffer(bollingerHandle, 0, 0, numCandlestoRetrieve, bollingerBuffer);
    }else if(band == "Lower"){
        // Copy the Bollinger Bands buffer
        CopyBuffer(bollingerHandle, 2, 0, numCandlestoRetrieve, bollingerBuffer);
    }else if(band == "Upper"){
        // Copy the Bollinger Bands buffer
        CopyBuffer(bollingerHandle, 1, 0, numCandlestoRetrieve, bollingerBuffer);
    }else{
        Print("Invalid Bollinger Bands Band Type");
        return(0.00);
    }
    // Check that the Bollinger Bands buffer is not empty
    if(bollingerBuffer[0] == EMPTY_VALUE){
        // Print an error message
        Print("Empty Bollinger Bands Buffer");
        return(0.00);
    }
    // Return the Bollinger Bands value
    return(bollingerBuffer[0]);
}



//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Check for a Bollinger Bands Upper Band
    Print(BollingerBands("Lower"));
}
