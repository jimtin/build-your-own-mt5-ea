//+------------------------------------------------------------------+
//| RSI Indicator                                                    |
//+------------------------------------------------------------------+
double RSI(){
    // Initialize the RSI value
    double rsiBuffer[];
    // Make it into an array
    ArraySetAsSeries(rsiBuffer, true);
    // Get the RSI Handle
    int rsiHandle = iRSI(_Symbol, _Period, rsiPeriod, PRICE_CLOSE);
    // Initialize the RSI count
    int rsiCount = 0;
    // If the handle is invalid, return 0
    if(rsiHandle == INVALID_HANDLE){
        return(0);
    }
    if (latestRSI == true){
        rsiCount = CopyBuffer(rsiHandle, 0, 0, 1, rsiBuffer);
    }else{
        rsiCount = CopyBuffer(rsiHandle, 0, 0, 2, rsiBuffer);
    }
    // If the copy buffer failed, return 0
    if(rsiCount == 0){
        return(0);
    }
    if(latestRSI == true){
        // Get the RSI value
        double rsiValue = rsiBuffer[0];
        // Return the RSI value
        return(rsiValue);
    }else{
        // Get the RSI value
        double rsiValue = rsiBuffer[1];
        // Return the RSI value
        return(rsiValue);
    }
}
