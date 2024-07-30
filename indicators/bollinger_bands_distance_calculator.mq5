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
//| Bollinger Bands Distance Indicator                               |
//| Investopedia Link: https://www.investopedia.com/terms/b/bollingerbands.asp |
//+------------------------------------------------------------------+
double BollingerBandsDistanceCalculator(string bandDistance){
    // Create a buffer for the Bollinger Bands
    double bollingerBandsUpperBuffer[];
    // Convert into an array
    ArraySetAsSeries(bollingerBandsUpperBuffer, true);
    // Create a buffer for the Bollinger Bands
    double bollingerBandsLowerBuffer[];
    // Convert into an array
    ArraySetAsSeries(bollingerBandsLowerBuffer, true);
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
    // Copy the Bollinger Bands buffer
    CopyBuffer(bollingerHandle, 0, 0, numCandlestoRetrieve, bollingerBuffer);
    // Copy the Bollinger Bands buffer
    CopyBuffer(bollingerHandle, 2, 0, numCandlestoRetrieve, bollingerBandsLowerBuffer);
    // Copy the Bollinger Bands buffer
    CopyBuffer(bollingerHandle, 1, 0, numCandlestoRetrieve, bollingerBandsUpperBuffer);
    // Check that the Bollinger Bands buffer is not empty
    if(bollingerBuffer[numCandles] == EMPTY_VALUE){
        // Print an error message
        Print("Empty Bollinger Bands Buffer");
        return(0.00);
    }
    // Check that the Bollinger Bands buffer is not empty
    if(bollingerBandsLowerBuffer[numCandles] == EMPTY_VALUE){
        // Print an error message
        Print("Empty Bollinger Bands Lower Buffer");
        return(0.00);
    }
    // Check that the Bollinger Bands buffer is not empty
    if(bollingerBandsUpperBuffer[numCandles] == EMPTY_VALUE){
        // Print an error message
        Print("Empty Bollinger Bands Upper Buffer");
        return(0.00);
    }
    // If the bandDistance is LowerMiddle
    if(bandDistance == "LowerMiddle"){
        // Return the Bollinger Bands Lower Band - Middle Band
        return(bollingerBuffer[numCandles] - bollingerBandsLowerBuffer[numCandles]);
    }else if(bandDistance == "UpperMiddle"){
        // Return the Bollinger Bands Upper Band - Middle Band
        return(bollingerBandsUpperBuffer[numCandles] - bollingerBuffer[numCandles]);
    }else if(bandDistance == "UpperLower"){
        // Return the Bollinger Bands Upper Band - Lower Band
        return(bollingerBandsUpperBuffer[numCandles] - bollingerBandsLowerBuffer[numCandles]);
    }else{
        Print("Invalid Bollinger Bands Band Distance Type");
        return(0.00);
    }
    // Return the Bollinger Bands value
    return(0.00);
}



//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Check for a Bollinger Bands Upper Band
    Print(BollingerBandsDistanceCalculator("LowerMiddle"));
}
